import 'package:json_annotation/json_annotation.dart';

part 'LoginModel.g.dart';

@JsonSerializable()
class LoginResponse {
  bool flag;
  String message;
  String data;

  LoginResponse(this.flag, this.message, this.data);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
