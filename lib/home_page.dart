import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ambulance_videos_page.dart';
import 'package:hear_me_app/fire_videos_page.dart' as firePage;
import 'package:hear_me_app/police_videos_page.dart' as policePage;
import 'chat_ui.dart';
import 'help_card.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLocationPermissionGranted = false;
  bool _hasShownLocationDialog = false;

  @override
  void initState() {
    super.initState();
    _checkInitialPermissionStatus();
  }

  Future<void> _checkInitialPermissionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _hasShownLocationDialog = prefs.getBool('hasShownLocationDialog') ?? false;

    if (!_hasShownLocationDialog) {
      Future.delayed(Duration.zero, () {
        _showLocationDialog();
      });
    } else {
      await _checkAndUpdatePermissionStatus();
    }
  }

  Future<void> _checkAndUpdatePermissionStatus() async {
    final permissionStatus = await _checkLocationPermission();
    setState(() {
      _isLocationPermissionGranted = permissionStatus == LocationPermission.whileInUse ||
          permissionStatus == LocationPermission.always;
    });
  }

  Future<void> _showLocationDialog() async {
    final prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Allow Location Access'),
          content: const Text(
            'HearMe needs location access to provide better emergency support. Would you like to enable location services?',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await prefs.setBool('hasShownLocationDialog', true);
                setState(() {
                  _hasShownLocationDialog = true;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _requestLocationPermission();
                await prefs.setBool('hasShownLocationDialog', true);
                setState(() {
                  _hasShownLocationDialog = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<LocationPermission> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location services in your device settings.'),
          duration: Duration(seconds: 4),
        ),
      );
      return LocationPermission.denied;
    }

    return await Geolocator.checkPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await _checkLocationPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Location access permanently denied. Please enable it from settings.',
          ),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () async {
              await Geolocator.openAppSettings();
              await _checkAndUpdatePermissionStatus();
            },
          ),
        ),
      );
    } else if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location access denied')),
      );
    } else {
      setState(() {
        _isLocationPermissionGranted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location access granted')),
      );
    }
  }

  Future<Position?> _getLocationAtStart() async {
    try {
      if (!_isLocationPermissionGranted) {
        return null;
      }
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBEE3F8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Shimaa, welcome to HearMe!",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "We are here to help",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FutureBuilder<Position?>(
                future: _getLocationAtStart(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Checking location access...',
                        style: TextStyle(fontSize: 16, color: Colors.purple),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  } else if (!_isLocationPermissionGranted) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          const Text(
                            'Location access needed',
                            style: TextStyle(fontSize: 16, color: Colors.orange),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: _requestLocationPermission,
                            child: const Text('Enable'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              HelpCard(
                image: 'assets/hospital.jpeg',
                readyVideoPage: const AmbulanceVideosPage(),
                chatPage: const ChatUI(),
              ),
              HelpCard(
                image: 'assets/fire.jpeg',
                readyVideoPage: const firePage.FireVideosPage(),
                chatPage: const ChatUI(),
              ),
              HelpCard(
                image: 'assets/police.jpeg',
                readyVideoPage: const policePage.PoliceVideosPage(),
                chatPage: const ChatUI(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}