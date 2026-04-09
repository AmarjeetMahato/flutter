import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: "Enter your email"),
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: "Enter your password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
