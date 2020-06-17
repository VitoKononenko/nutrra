import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nutrra/user/api/dto/login_request.dart';
import 'package:nutrra/user/api/dto/login_response.dart';
import 'package:nutrra/user/api/dto/register_request.dart';
import 'package:nutrra/user/api/dto/register_response.dart';
import 'package:nutrra/utils/store_interactor.dart';

import '../user.dart';

class HttpUserRepo implements UserRepo {
  // Probably need to use global client but for time efficiency...
  Dio _client;

  HttpUserRepo() {
    _client = Dio(
      BaseOptions(baseUrl: 'https://api.nutrra.com/users/'),
    );

    _client.transformer = FlutterTransformer();
  }

  @override
  Future<User> login(LoginPayload payload) async {
    try {
      final response = await _client.post(
        '/login',
        data: LoginRequest.fromLoginPayload(payload).toJson(),
      );
      final responseData = LoginResponse.fromJson(response.data);
      final interactor = GetIt.I.get<StoreInteractor>();
      interactor.setToken(responseData.data.token);

      return responseData.toUser();
    } on DioError catch (error) {
      if (error.response != null && error.response.data != null) {
        final response = LoginResponse.fromJson(error.response.data);
        print('Login exception: ${response.errors}');
        throw InvalidLoginDataException();
      }

      rethrow;
    }
  }

  @override
  Future<User> register(RegisterPayload payload) async {
    try {
      final response = await _client.post(
        '/register',
        data: RegisterRequest.fromRegisterPayload(payload).toJson(),
      );
      return RegisterResponse.fromJson(response.data).toUser();
    } on DioError catch (error) {
      if (error.response != null && error.response.data != null) {
        final response = RegisterResponse.fromJson(error.response.data);
        print('Register exception: ${response.errors}');
        throw EmailAlreadyInUseException();
      }

      rethrow;
    }
  }

  @override
  Future<User> getCurrentUser() async {
    final interactor = GetIt.I.get<StoreInteractor>();
    final token = await interactor.getToken();

    if (token == null) {
      return null;
    }

    return User(
      id: JwtDecoder.decode(token)['sub'],
    );
  }

  @override
  Future<void> logOut() async {
    final interactor = GetIt.I.get<StoreInteractor>();
    await interactor.setToken(null);
  }
}
