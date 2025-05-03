import 'package:flutter/material.dart';
import 'verification_page.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late String _statusMessage = "";

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword({required String email}) async {
    // أي منطق لإعادة تعيين كلمة المرور هنا
    setState(() {
      _statusMessage =
          "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.";
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = const Color(0xFF3D5A98);

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
                "Forgot Password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your email to reset your password.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _key,
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Email address',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'example@email.com',
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
                          prefixIcon: Icon(Icons.email, color: mainColor),
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
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await resetPassword(
                                email: _emailController.text.trim(),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const VerificationPage(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Send Email',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
