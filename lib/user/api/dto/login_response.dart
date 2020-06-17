import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../user.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(nullable: false)
  final bool success;

  final LoginResponseData data;

  final List<String> errors;

  LoginResponse({
    this.success,
    this.data,
    this.errors,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  User toUser() {
    return User(
      id: JwtDecoder.decode(data.token)['sub'],
    );
  }
}

@JsonSerializable(nullable: false)
class LoginResponseData {
  String token;
  int expires;

  LoginResponseData({
    this.token,
    this.expires,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) => _$LoginResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
