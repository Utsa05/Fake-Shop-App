import 'package:cart_product_ca_app/features/auth/data/models/auth_register_response_model.dart';

abstract class AuthEvent {}

class InitEvent extends AuthEvent {}

class AuthRegisterUserEvent extends AuthEvent {
  final AuthRegisterResposneModel user;

  AuthRegisterUserEvent({required this.user});
}
