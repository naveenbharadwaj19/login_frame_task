import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:login_frame_task/datas/models/auth_models.dart';
import 'package:login_frame_task/datas/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String? jwt;
  final AuthenticationRepository _authRepo = AuthenticationRepository();

  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> onContinueButtonPressed() async {
    try {
      String mobileNumber = mobileNumberController.text.trim();
      emit(MobileNumberSubmitted());
      var res = await _authRepo.sentOtp(mobileNumber);
      if (res != null) {
        Future.delayed(const Duration(seconds: 1));
        emit(MobileNumberSuccess(mobileNumber));
      }
    } catch (e) {
      print(e);
      emit(MobileNumberError("Something went wrong"));
    }
  }

  Future<void> onVerifyButtonPressed() async {
    try {
      String mobileNumber = mobileNumberController.text.trim();
      String otp = otpController.text;
      emit(OtpSubmitted());
      var res = await _authRepo.verifyOtp(requestId: mobileNumber, code: otp);
      if (res != null) {
        Future.delayed(const Duration(seconds: 1));
        OtpSuccess(res);
        jwt = res.jwt;
        if (res.isProfileExist != null) {
          if (res.isProfileExist == true) {
            emit(ProfileExists());
          } else if (res.isProfileExist == false) {
            emit(ProfileNotExists());
          }
        } else {
          emit(ProfileNotExists());
        }
        _clearControllers;
      }
    } catch (e) {
      print(e);
      emit(OtpError("Something went wrong"));
    }
  }

  /// clear controllers
  void  get _clearControllers {
    mobileNumberController.clear();
    otpController.clear();
  }

  @override
  Future<void> close() {
    mobileNumberController.dispose();
    otpController.dispose();
    return super.close();
  }
}
