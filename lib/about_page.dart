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
      title: 'About Page',
      home: const AboutPage(),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    bool isEnglish = selectedLanguage == 'English';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isEnglish ? 'About HearMe' : 'حول HearMe',
          style: const TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Language selection dropdown
            Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                value: selectedLanguage,
                items:
                    ['English', 'العربية'].map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(
                          language,
                          style: const TextStyle(color: Color(0xFF2C3E73)),
                        ),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
              ),
            ),

            const SizedBox(height: 30),

            // App name and version
            Text(
              isEnglish
                  ? 'HearMe for Android\nVersion: 1.0.0'
                  : 'HearMe لنظام أندرويد\nالإصدار: 1.0.0',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E73),
              ),
            ),
            const SizedBox(height: 20),

            // About text
            Text(
              isEnglish
                  ? 'HearMe and the HearMe logo are trademarks of HearMe Inc. All rights reserved.\n\nThis app is built using open-source technologies and aims to support the deaf and mute community by providing an accessible and effective communication platform.'
                  : 'HearMe وشعار HearMe هي علامات تجارية مسجلة لشركة HearMe. جميع الحقوق محفوظة.\n\nتم تطوير هذا التطبيق باستخدام تقنيات مفتوحة المصدر، ويهدف إلى دعم مجتمع الصم والبكم من خلال توفير منصة تواصل فعّالة وسهلة الاستخدام.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Color(0xFF2C3E73),
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
