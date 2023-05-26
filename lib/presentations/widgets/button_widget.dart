import 'package:flutter/material.dart';
import 'package:login_frame_task/presentations/configs/custom_colors.dart';

class Button extends StatelessWidget {
  void Function()? onPressed;
  double radius;
  String buttonName;
  double? height;
  double? width;

  Button({
    required this.onPressed,
    required this.buttonName,
    this.radius = 10,
    this.height = 50,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(CustomColors.buttonColor),
          elevation: MaterialStateProperty.all(8),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
