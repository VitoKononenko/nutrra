part of 'user.dart';

abstract class AuthPayload {
  static bool validateEmail(String email) => EmailValidator.validate(email);
  static bool validatePassword(String password) => password.length >= 6 && password.length <= 25;

  final String email;
  final String password;

  AuthPayload({
    @required this.email,
    @required this.password,
  })  : assert(email != null),
        assert(validateEmail(email)),
        assert(password != null),
        assert(validatePassword(password));
}

class LoginPayload extends AuthPayload {
  LoginPayload({
    @required String email,
    @required String password,
  }) : super(email: email, password: password);
}

class RegisterPayload extends AuthPayload {
  final String confirmPassword;

  RegisterPayload({
    @required String email,
    @required String password,
    @required this.confirmPassword,
  })  : assert(confirmPassword == password),
        super(email: email, password: password);
}

abstract class UserRepo {
  Future<User> register(RegisterPayload payload);
  Future<User> login(LoginPayload payload);
  Future<User> getCurrentUser();
  Future<void> logOut();
}

class EmailAlreadyInUseException implements Exception {}

class InvalidLoginDataException implements Exception {}
