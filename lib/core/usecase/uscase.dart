import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}
