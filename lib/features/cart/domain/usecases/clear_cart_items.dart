// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/core/params/no_param.dart';
import 'package:cart_product_ca_app/core/usecase/uscase.dart';
import 'package:cart_product_ca_app/features/cart/domain/repositories/cart_local_respository.dart';
import 'package:dartz/dartz.dart';

class ClearCartItems extends UseCase<void, NoParam> {
  final CartLocalRespository cartLocalRespository;
  ClearCartItems({
    required this.cartLocalRespository,
  });

  @override
  Future<Either<Failure, void>> call(NoParam param) {
    return cartLocalRespository.clearCart();
  }
}
