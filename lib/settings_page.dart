import 'package:flutter/material.dart';
import 'about_page.dart';
import 'Notifications_page.dart';
import 'helpcenter_page.dart';
import 'language_page.dart';
import 'profile_page.dart';
import 'appearance_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Shimaa Mansour',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('sm3882595@gmail.com'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
              const Divider(),

              ListTile(
                title: const Text('Language'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LanguageSelectionScreen(),
                    ),
                  );
                },
              ),
              const Divider(),

              ListTile(
                title: const Text('Appearance'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppearancePage(),
                    ),
                  );
                },
              ),
              const Divider(),

              ListTile(
                title: const Text('Notifications'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsPage(),
                    ),
                  );
                },
              ),
              const Divider(),

              ListTile(
                title: const Text('Help Center'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpCenterScreen()),
                  );
                },
              ),
              const Divider(),

              ListTile(
                title: const Text('About'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
