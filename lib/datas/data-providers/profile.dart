import 'dart:convert';

import 'package:http/http.dart' as http;

import 'base_url.dart';

class Profile with Base {
  Future<http.Response> profileSubmit(
      {required String token,
      required String name,
      required String email}) async {
    var res = await http.post(Uri.parse("$baseUrl/profilesubmit.php"),
        headers: {"Token": token},
        body: json.encode({
          "name": name,
          "email": email,
        }));
    return res;
  }
}
