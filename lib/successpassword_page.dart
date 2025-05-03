import 'package:flutter/material.dart';

class SuccessPasswordPage extends StatelessWidget {
  const SuccessPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF3D5A98);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: mainColor,
                size: 100,
              ),
              const SizedBox(height: 30),
              const Text(
                'Password Updated!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your password has been changed successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // بعد النجاح، يرجع المستخدم لصفحة تسجيل الدخول مثلاً
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
