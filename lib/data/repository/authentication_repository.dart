import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/authenication_datasource.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';
import 'package:flutter_ecommerce_shop/util/auth_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> Login(String username, String password);
}

class AuthenticationRepository implements IAuthRepository {
  final IauthenticationDataSource _datasource = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return const Right('ثبت نام انجام شد');
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> Login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        return const Right('شما وارد شدید');
      } else {
        return const Left('خطایی روی ورود پیش آمد');
      }
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطای لاگین');
    }
  }
}
