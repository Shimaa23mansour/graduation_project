import 'package:flutter/material.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance Settings'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3E73),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your preferred theme:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Light Theme'),
              onTap: () {
                print('Light Theme selected');
              },
            ),
            ListTile(
              title: const Text('Dark Theme'),
              onTap: () {
                print('Dark Theme selected');
              },
            ),
          ],
        ),
      ),
    );
  }
}
