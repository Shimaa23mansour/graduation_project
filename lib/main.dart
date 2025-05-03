import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'welcome_page.dart';
import 'splash_page.dart';
import 'onboarding_2.dart'; // أضفت الـ import لصفحة Onboarding2
import 'reset_password_screen.dart'; // ✅ أضفت صفحة Reset Password

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HearMe',
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomePage(),
        '/onboarding_2': (context) => const Onboarding2(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/reset': (context) => const ResetPasswordScreen(), // ✅ أضفت الـ route
      },
    );
  }
}
