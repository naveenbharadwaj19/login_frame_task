import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_frame_task/logics/cubit/profile_cubit.dart';
import 'package:login_frame_task/presentations/screens/home_screen.dart';
import 'package:login_frame_task/presentations/widgets/button_widget.dart';
import 'package:login_frame_task/presentations/widgets/loading_spinner.dart';

class CreateProfileScreen extends StatelessWidget {
  static const routeName = "/create-profile";

  bool isEmailValid(String email) {
    final pattern =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(email);
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: form,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    "Looks like you are new here.Tell us a bit about yourself",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Name",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,),
                  child: TextFormField(
                    controller: context.read<ProfileCubit>().nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Cannot be Empty";
                      }
                      return null;
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Email",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,),
                  child: TextFormField(
                    controller: context.read<ProfileCubit>().emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Cannot be empty";
                      } else if (!isEmailValid(v)) {
                        return "Not a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileError) {
                        showSnackbar(context, state.message);
                      } else if (state is ProfileSuccess) {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      }
                    },
                    builder: (context, state) {
                      if (state is ProfileSubmitted) {
                        return loadingSpinner();
                      }
                      return Button(
                          onPressed: () {
                            if (form.currentState!.validate()) {
                              context.read<ProfileCubit>().onSubmitPressed();
                            }
                          },
                          buttonName: "Submit");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
