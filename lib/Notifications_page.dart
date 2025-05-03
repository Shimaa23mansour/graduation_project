import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications',
      home: const NotificationsPage(),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    bool isEnglish = selectedLanguage == 'English';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E73)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          isEnglish ? 'Notifications' : 'الإشعارات',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E73),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEnglish
                  ? 'Manage your notifications'
                  : 'أماكن استلام الإشعارات',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E73),
              ),
            ),
            const SizedBox(height: 20),
            _buildNotificationSetting(
              Icons.email,
              isEnglish ? 'Email' : 'البريد الإلكتروني',
              isEnglish ? 'On, Suggested' : 'مُفعّل، مقترح',
            ),
            _buildNotificationSetting(
              Icons.sms,
              isEnglish ? 'SMS' : 'رسائل SMS',
              isEnglish ? 'Activated' : 'مفعّل',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSetting(IconData icon, String title, String status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2C3E73), size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2C3E73),
                  ),
                ),
                const SizedBox(height: 4),
                Text(status, style: const TextStyle(color: Color(0xFF6C88B7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
