import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_event.dart';
import 'package:flutter_ecommerce_shop/bloc/authentication/auth_state.dart';
import 'package:flutter_ecommerce_shop/data/repository/authentication_repository.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();
  AuthBloc() : super(AuthInitiateState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.Login(event.username, event.password);
      emit(AuthResponseState(response));
    });
    on<AuthRegisterRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.register(
          event.username, event.password, event.passwordConfirm);
      emit(AuthResponseState(response));
    });
  }
}
