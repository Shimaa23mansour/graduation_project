import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Language",
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _header(),
            const SizedBox(height: 50),
            _languageButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Choose Your Language",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E73),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Select a language to continue",
          style: TextStyle(fontSize: 16, color: Color(0xFF6C88B7)),
        ),
      ],
    );
  }

  Widget _languageButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLanguageButton("العربية", () {
          print("تم اختيار العربية");
        }),
        const SizedBox(height: 20),
        _buildLanguageButton("English", () {
          print("English selected");
        }),
      ],
    );
  }

  Widget _buildLanguageButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: const Color(
          0xFFE8F0FE,
        ), // نفس لون الـ Cards في البروفايل
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2C3E73),
        ),
      ),
    );
  }
}
