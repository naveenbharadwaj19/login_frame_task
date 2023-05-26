import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_frame_task/logics/cubit/authentication_cubit.dart';
import 'package:login_frame_task/presentations/screens/create_profile_screen.dart';
import 'package:login_frame_task/presentations/screens/home_screen.dart';
import 'package:login_frame_task/presentations/widgets/button_widget.dart';
import 'package:login_frame_task/presentations/widgets/loading_spinner.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatelessWidget {
  static const routeName = "/verify-otp";

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
                    "Enter OTP",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    // ignore: lines_longer_than_80_chars
                    "OTP sent to +91${context.read<AuthenticationCubit>().mobileNumberController.text}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: PinCodeTextField(
                    controller:
                        context.read<AuthenticationCubit>().otpController,
                    autoDisposeControllers: false,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.slide,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    enableActiveFill: true,
                    onChanged: (v) {},
                    onCompleted: (v) {},
                    appContext: context,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Cannot be empty";
                      } else if (containsAlphabets(v) ||
                          v.contains(" ") ||
                          containsSpecialCharacters(v)) {
                        return "Not a valid OTP format";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        color: Color(0xFFff8062),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if (state is OtpError) {
                        showSnackbar(context, state.message);
                      } else if (state is ProfileExists) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.routeName, (route) => false);
                      } else if (state is ProfileNotExists) {
                        Navigator.pushNamedAndRemoveUntil(context,
                            CreateProfileScreen.routeName, (route) => false);
                      }
                    },
                    builder: (context, state) {
                      if (state is OtpSubmitted) {
                        return loadingSpinner();
                      }
                      return Button(
                        width: 320,
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            context
                                .read<AuthenticationCubit>()
                                .onVerifyButtonPressed();
                          }
                        },
                        buttonName: "Verify",
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
