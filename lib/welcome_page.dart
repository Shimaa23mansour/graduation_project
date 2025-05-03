import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // إخفاء الـ status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            // إضافة تأثيرات على الصورة مثل الحواف المدورة والظلال
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // حواف مدورة
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // تأثير الظل
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // حواف مدورة
                child: Image.asset(
                  'assets/welcome.jpeg',
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.7,
                  fit: BoxFit.cover, // تغطية الصورة بشكل كامل
                ),
              ),
            ),
            const SizedBox(height: 20),
            // تحسين النص
            const Text(
              "Step into a world that gets you",
              style: TextStyle(
                fontSize: 22, // زيادة حجم الخط قليلاً
                fontWeight: FontWeight.bold, // جعل الجملة بولد
                color: Colors.black87,
                letterSpacing: 1.5, // زيادة تباعد الحروف
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // إضافة دائرة صغيرة لتمثيل الأنيمشن أو التفاعل
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/onboarding_2');
                  },
                  icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
