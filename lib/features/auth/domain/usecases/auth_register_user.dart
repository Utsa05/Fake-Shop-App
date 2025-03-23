// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/core/usecase/uscase.dart';
import 'package:cart_product_ca_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/auth_register_response_model.dart';

class AuthRegisterUser extends UseCase<AuthRegisterResposneModel, AuthRegisterResposneModel> {
  final AuthRepository authRepository;
  AuthRegisterUser({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, AuthRegisterResposneModel>> call(AuthRegisterResposneModel param) async {
    return await authRepository.registerNewUser(param);
  }
}
