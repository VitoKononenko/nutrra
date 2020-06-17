import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../user.dart';

class LoginScreenPresenter extends ChangeNotifier {
  String _email;
  String _password;

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  Future<User> login() async {
    return GetIt.I.get<UserService>().login(
          LoginPayload(
            email: _email,
            password: _password,
          ),
        );
  }
}
