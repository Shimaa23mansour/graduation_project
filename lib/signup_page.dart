import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D5A98),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                "Full Name",
                Icons.person,
                false,
                TextInputType.text,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                "Email",
                Icons.email,
                false,
                TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                "Phone Number",
                Icons.phone,
                false,
                TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                "Password",
                Icons.lock,
                true,
                TextInputType.text,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                "Confirm Password",
                Icons.lock,
                true,
                TextInputType.text,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add signup logic
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF3D5A98),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white, // لون أبيض للنص عشان يبان
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color(0xFF3D5A98)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    String hintText,
    IconData icon,
    bool obscure,
    TextInputType keyboardType,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: const Color(0xFF3D5A98).withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
      ),
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        if (hintText == "Email" &&
            !RegExp(
              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
            ).hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        if (hintText == "Phone Number" &&
            !RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        if (hintText == "Password" && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
