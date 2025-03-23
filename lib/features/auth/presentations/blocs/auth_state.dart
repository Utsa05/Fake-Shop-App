import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/auth/data/models/auth_register_response_model.dart';

class AuthState {
  AuthState clone() {
    return AuthState();
  }
}

class AuthResiterLoadingState extends AuthState {}

class AuthResiterCompletedState extends AuthState {
  final AuthRegisterResposneModel user;

  AuthResiterCompletedState({required this.user});
}

class AuthResiterFailureState extends AuthState {
  final Failure failure;

  AuthResiterFailureState({required this.failure});
}
