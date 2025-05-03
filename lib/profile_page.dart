import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFF2C3E73),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E73)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
            const SizedBox(height: 10),
            const Text(
              "shimaa mansour",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E73),
              ),
            ),
            const Text(
              "sm3882595@gmail.com",
              style: TextStyle(fontSize: 16, color: Color(0xFF6C88B7)),
            ),
            const SizedBox(height: 30),
            _buildInfoTile(Icons.phone, "Phone", "+1121807929"),
            _buildInfoTile(Icons.location_on, "Location", "Cairo, Egypt"),
            _buildSettingsTile(Icons.settings, "Settings"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2C3E73)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E73),
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        // ضع هنا أي إجراء عند الضغط على "Settings"
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0FE),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF2C3E73)),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E73),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
