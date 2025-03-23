import "package:cart_product_ca_app/core/error/failure.dart";
import "package:dartz/dartz.dart";

import "../../data/models/auth_register_response_model.dart";
import "../entities/auth_register_param.dart";

abstract class AuthRepository {
  Future<Either<Failure, AuthRegisterResposneModel>> registerNewUser(
      AuthRegisterResposneModel param);
}
