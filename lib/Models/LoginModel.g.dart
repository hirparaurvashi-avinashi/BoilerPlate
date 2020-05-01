// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
      json['flag'] as bool,
      json['message'] as String,
      json['data'] == null
          ? null
          : UserToken.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'message': instance.message,
      'data': instance.data
    };

UserToken _$UserTokenFromJson(Map<String, dynamic> json) {
  return UserToken(json['id'] as String);
}

Map<String, dynamic> _$UserTokenToJson(UserToken instance) =>
    <String, dynamic>{'id': instance.id};
