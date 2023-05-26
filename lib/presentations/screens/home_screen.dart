import 'package:flutter/material.dart';
import 'package:login_frame_task/presentations/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home-screen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 22,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Home",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    ));
  }
}
