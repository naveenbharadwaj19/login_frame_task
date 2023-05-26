import 'package:flutter/material.dart';
import 'package:login_frame_task/presentations/configs/custom_colors.dart';

Widget loadingSpinner() => const Center(
      child: CircularProgressIndicator(
        backgroundColor: CustomColors.buttonColor,
        color: Colors.white,
      ),
    );
