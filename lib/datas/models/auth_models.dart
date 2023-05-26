import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class SendOtpResponseModel {
  bool status;
  String response;
  @JsonKey(name: "request_id")
  String requestId;

  SendOtpResponseModel(
      {required this.status, required this.response, required this.requestId});

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpResponseModelToJson(this);
}

@JsonSerializable()
class VerifyOtpResponseModel {
  bool? status;
  @JsonKey(name: "profile_exists")
  bool? isProfileExist;
  String? jwt;

  VerifyOtpResponseModel(
      {required this.status, required this.isProfileExist, required this.jwt});

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseModelToJson(this);
}
