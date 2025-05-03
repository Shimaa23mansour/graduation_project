import 'package:flutter/material.dart';
import 'successpassword_page.dart'; // تأكد من استيراد صفحة النجاح

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late String _statusMessage = "";

  final Color mainColor = const Color(0xFF3D5A98);

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void updatePassword() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _statusMessage = "كلمات المرور غير متطابقة.";
      });
    } else {
      setState(() {
        _statusMessage = "تم تحديث كلمة المرور بنجاح.";
      });

      // بعد تحديث كلمة المرور بنجاح، انتقل إلى صفحة SuccessPasswordPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessPasswordPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
                const SizedBox(height: 40),
                Text(
                  "New Password",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter your new password.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 40),
                // Password fields
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter new password',
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
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
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
                          onPressed: updatePassword,
                          child: const Text(
                            'Save Password',
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
      ),
    );
  }
}
