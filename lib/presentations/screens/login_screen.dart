import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_frame_task/logics/cubit/authentication_cubit.dart';
import 'package:login_frame_task/presentations/screens/verify_otp_screen.dart';
import 'package:login_frame_task/presentations/widgets/button_widget.dart';
import 'package:login_frame_task/presentations/widgets/loading_spinner.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login-screen";

  bool containsAlphabets(String str) {
    final RegExp regex = RegExp('[a-zA-Z]');

    return regex.hasMatch(str);
  }

  bool containsSpecialCharacters(String str) {
    final RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    return regex.hasMatch(str);
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      "assets/images/otp.png",
                      height: 100,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "We will send you a ",
                        ),
                        TextSpan(
                            text: "OTP",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                          text: " on this mobile number",
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(
                    "Enter Mobile Number",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    controller: context
                        .read<AuthenticationCubit>()
                        .mobileNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      prefixText: '+91',
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Cannot be empty";
                      } else if (v.length != 10 ||
                          containsAlphabets(v) ||
                          containsSpecialCharacters(v)) {
                        return "Not a valid number";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 40),
                    child:
                        BlocConsumer<AuthenticationCubit, AuthenticationState>(
                      listener: (context, state) {
                        if (state is MobileNumberError) {
                          showSnackbar(context, state.message);
                        } else if (state is MobileNumberSuccess) {
                          Navigator.pushNamed(
                              context, VerifyOtpScreen.routeName);
                        }
                      },
                      builder: (context, state) {
                        if (state is MobileNumberSubmitted) {
                          return loadingSpinner();
                        }

                        return Button(
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                context
                                    .read<AuthenticationCubit>()
                                    .onContinueButtonPressed();
                              }
                            },
                            buttonName: "Continue");
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
