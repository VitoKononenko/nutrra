import 'package:json_annotation/json_annotation.dart';

import '../../user.dart';

part 'register_request.g.dart';

@JsonSerializable(nullable: false)
class RegisterRequest {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequest({
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  factory RegisterRequest.fromRegisterPayload(RegisterPayload payload) {
    return RegisterRequest(
      email: payload.email,
      password: payload.password,
      confirmPassword: payload.confirmPassword,
    );
  }
}
