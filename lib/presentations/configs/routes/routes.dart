import 'package:flutter/material.dart';
import 'package:login_frame_task/presentations/screens/create_profile_screen.dart';
import 'package:login_frame_task/presentations/screens/home_screen.dart';
import 'package:login_frame_task/presentations/screens/login_screen.dart';
import 'package:login_frame_task/presentations/screens/verify_otp_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  VerifyOtpScreen.routeName: (context) => VerifyOtpScreen(),
  CreateProfileScreen.routeName: (context) => CreateProfileScreen(),
  HomeScreen.routeName : (context) => HomeScreen()
};
