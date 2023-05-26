import 'dart:convert';

import 'package:login_frame_task/datas/data-providers/authentication.dart';
import 'package:login_frame_task/datas/models/auth_models.dart';


class AuthenticationRepository {
  final Authentication _authentication = Authentication();

  Future<SendOtpResponseModel?> sentOtp(String mobileNumber) async {
    var res = await _authentication.sentOtp(mobileNumber);
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      SendOtpResponseModel sendOtpResponseModel =
          SendOtpResponseModel.fromJson(body);
      return sendOtpResponseModel;
    }
    throw Exception("${res.statusCode},${res.body}");
  }

  Future<VerifyOtpResponseModel?> verifyOtp(
      {required String requestId, required String code}) async {
    var res = await _authentication.verifyOtp(requestId: requestId, code: code);
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      VerifyOtpResponseModel verifyOtpResponseModel =
          VerifyOtpResponseModel.fromJson(body);
      return verifyOtpResponseModel;
    }
    throw Exception("${res.statusCode},${res.body}");
  }
}
