import 'package:json_annotation/json_annotation.dart';

import '../../user.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(nullable: false)
  final bool success;

  final int id;

  final List<String> errors;

  RegisterResponse({
    this.success,
    this.id,
    this.errors,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  User toUser() {
    return User(
      id: id,
    );
  }
}
