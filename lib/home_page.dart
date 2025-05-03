import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showLocationDialog();
    });
  }

  Future<void> _showLocationDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Allow Location Access'),
          content: const Text(
            'Would you allow us to access your location to provide better emergency support?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Deny
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                LocationPermission permission =
                    await Geolocator.requestPermission();
                if (permission == LocationPermission.whileInUse ||
                    permission == LocationPermission.always) {
                  setState(() {});
                } else if (permission == LocationPermission.deniedForever) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Location access permanently denied. Please enable it from settings.',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Location access denied')),
                  );
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<Position> _getLocationAtStart() async {
    try {
      Position position = await _determinePosition();
      return position;
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
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
              // Navigate to settings page (create SettingsPage later)
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
              FutureBuilder<Position>(
                future: _getLocationAtStart(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Getting location...',
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
