import 'dart:io';

import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:cart_product_ca_app/features/auth/data/models/auth_register_response_model.dart';
import 'package:cart_product_ca_app/features/auth/domain/entities/auth_register_param.dart';
import 'package:cart_product_ca_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl({required AuthDatasource authDatasource})
      : _authDatasource = authDatasource;

  @override
  Future<Either<Failure, AuthRegisterResposneModel>> registerNewUser(
      AuthRegisterResposneModel param) async {
    try {
      AuthRegisterResposneModel result =
          await _authDatasource.registerNewUser(param);
      return Right(result);
    } on SocketException {
      return Left(Failure(message: "No Internet Connection"));
    } catch (e) {
      return Left(Failure());
    }
  }
}
