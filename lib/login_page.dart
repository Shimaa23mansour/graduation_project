import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _forgotPassword(context),
            _signup(context),
          ],
        ),
      ),
    );
  }

  Widget _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E73),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Enter your credentials to login",
          style: TextStyle(color: Color(0xFF6C88B7), fontSize: 16),
        ),
      ],
    );
  }

  Widget _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color(0xFFE8F0FE),
            filled: true,
            prefixIcon: const Icon(Icons.person, color: Color(0xFF2C3E73)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color(0xFFE8F0FE),
            filled: true,
            prefixIcon: const Icon(Icons.lock, color: Color(0xFF2C3E73)),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
            backgroundColor: const Color(0xFF3D5A98),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/reset'); // تم الربط هنا
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Color(0xFF2C3E73)),
      ),
    );
  }

  Widget _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black87),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Color(0xFF2C3E73)),
          ),
        ),
      ],
    );
  }
}
