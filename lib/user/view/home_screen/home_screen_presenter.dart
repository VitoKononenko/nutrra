import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../user.dart';

class HomeScreenPresenter extends ChangeNotifier {
  UserService _userService = GetIt.I.get<UserService>();
  User _user;

  User get user => _user;

  HomeScreenPresenter() {
    init();
  }

  Future<void> init() async {
    _user = await _userService.getCurrentUser();
    notifyListeners();
  }

  Future<void> logOut() async {
    return _userService.logOut();
  }
}
