// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class AuthRegisterParam extends Equatable {
  int id;
  String username;
  String email;
  String password;

  AuthRegisterParam({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, username, email, password];
}
