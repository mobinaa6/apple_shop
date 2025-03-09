import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';
import 'package:flutter_ecommerce_shop/util/auth_manager.dart';
import 'package:flutter_ecommerce_shop/util/dio_provider.dart';

abstract class IauthenticationDataSource {
  Future<void> register(
      String username, String password, String passwordConfirm);

  Future<String> login(String usernames, String password);
}

class AuthenticationRemote implements IauthenticationDataSource {
  final Dio _dio = DioProvider.createDioWithOutHeader();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      var response = await _dio.post('collections/users/records', data: {
        'username': username,
        'name': username,
        'password': password,
        'passwordConfirm': passwordConfirm
      });
      if (response.statusCode == 200) {
        await login(username, password);
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message'],
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response =
          await _dio.post('collections/users/auth-with-password', data: {
        'identity': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        AuthManager.saveToken(response.data?['token']);
        AuthManager.saveID(response.data?['record']['id']);
        return response.data?['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message'],
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
    return '';
  }
}
