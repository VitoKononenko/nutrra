import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../user.dart';

class RegisterScreenPresenter extends ChangeNotifier {
  String _email;
  String _password;
  String _confirmPassword;

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set confirmPassword(String value) {
    _confirmPassword = value;
  }

  Future<User> register() async {
    return GetIt.I.get<UserService>().register(
          RegisterPayload(
            email: _email,
            password: _password,
            confirmPassword: _confirmPassword,
          ),
        );
  }
}
