import 'package:ecommerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EcommercApp());
}

class EcommercApp extends StatelessWidget {
  const EcommercApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}