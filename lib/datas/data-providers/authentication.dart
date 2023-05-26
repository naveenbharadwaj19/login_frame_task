import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_frame_task/datas/data-providers/base_url.dart';

class Authentication with Base {
  Future<http.Response> sentOtp(String mobileNumber) async {
    var res = await http.post(
      Uri.parse("$baseUrl/sendotp.php"),
      body: json.encode({
        "mobile": mobileNumber,
      }),
    );
    return res;
  }

  Future<http.Response> verifyOtp(
      {required String requestId, required String code}) async {
    var res = await http.post(
      Uri.parse("$baseUrl/verifyotp.php"),
      body: json.encode({
        "request_id": requestId,
        "code": code,
      }),
    );
    return res;
  }
}
