import 'dart:convert';

import 'package:login_frame_task/datas/data-providers/profile.dart';
import 'package:login_frame_task/datas/models/profile_models.dart';

class ProfileRepository {
  final Profile _profile = Profile();

  Future<ProfileSubmitResponseModel?> profileSubmit(
      {required String token,
      required String name,
      required String email}) async {
    var res =
        await _profile.profileSubmit(token: token, name: name, email: email);
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      ProfileSubmitResponseModel profileSubmitResponseModel =
          ProfileSubmitResponseModel.fromJson(body);
      return profileSubmitResponseModel;
    }
    throw Exception("${res.statusCode},${res.body}");
  }
}
