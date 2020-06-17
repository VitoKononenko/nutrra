import 'package:json_annotation/json_annotation.dart';

import '../../user.dart';

part 'login_request.g.dart';

@JsonSerializable(nullable: false)
class LoginRequest {
  final String email;
  final String password;
  final String confirmPassword;

  LoginRequest({
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  factory LoginRequest.fromLoginPayload(LoginPayload payload) {
    return LoginRequest(
      email: payload.email,
      password: payload.password,
    );
  }
}
