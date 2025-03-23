// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:cart_product_ca_app/features/auth/domain/usecases/auth_register_user.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRegisterUser _authRegisterUser;
  AuthBloc(
    this._authRegisterUser,
  ) : super(AuthState()) {
    on<AuthRegisterUserEvent>(_registerUser);
  }

  void _registerUser(
      AuthRegisterUserEvent event, Emitter<AuthState> emit) async {
    final result = await _authRegisterUser(event.user);

    result.fold((error) {}, (success) {});
  }
}
