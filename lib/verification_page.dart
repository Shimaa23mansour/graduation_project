import 'package:flutter/material.dart';
import 'newpassword_page.dart'; // تأكد من إزالة المسافة الزائدة

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _codeController = TextEditingController();
  late String _statusMessage = "";
  final Color mainColor = const Color(0xFF3D5A98);

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void verifyCode() {
    setState(() {
      _statusMessage = "تم التحقق من الكود بنجاح!";
    });

    // بعد ثانية (اختياري)، ننتقل لصفحة كلمة المرور الجديدة
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewPasswordPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.black),
              ),
              const SizedBox(height: 40),
              Text(
                "Verification",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter the verification code sent to your email.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Verification Code',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter code',
                        filled: true,
                        fillColor: mainColor.withOpacity(0.1),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.lock, color: mainColor),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                        onPressed: verifyCode,
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    if (_statusMessage.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        _statusMessage,
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
