import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

@JsonSerializable(includeIfNull: true)
class ProfileSubmitResponseModel {
  bool? status;
  String? response;

  ProfileSubmitResponseModel({required this.status, required this.response});

  factory ProfileSubmitResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileSubmitResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileSubmitResponseModelToJson(this);
}
