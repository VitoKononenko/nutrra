part of 'user.dart';

class UserService {
  final UserRepo _repo = GetIt.I.get<UserRepo>();

  User _currentUser;

  Future<User> register(RegisterPayload payload) async {
    await _repo.register(payload);
    return _repo.login(
      LoginPayload(email: payload.email, password: payload.password),
    );
  }

  Future<User> login(LoginPayload payload) async {
    _currentUser = await _repo.login(payload);
    return _currentUser;
  }

  Future<void> logOut() async {
    _currentUser = null;
    await _repo.logOut();
  }

  Future<User> getCurrentUser() async {
    if (_currentUser == null) {
      _currentUser = await _repo.getCurrentUser();
    }

    return _currentUser;
  }
}
