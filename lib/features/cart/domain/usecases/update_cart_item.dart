// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/core/usecase/uscase.dart';
import 'package:cart_product_ca_app/features/cart/data/models/cart_model.dart';
import 'package:cart_product_ca_app/features/cart/domain/repositories/cart_local_respository.dart';

class UpdateCartItem extends UseCase<void, CartItemModel> {
  final CartLocalRespository cartLocalRespository;
  UpdateCartItem({
    required this.cartLocalRespository,
  });
  @override
  Future<Either<Failure, void>> call(CartItemModel param) {
    return cartLocalRespository.updateCartItem(param);
  }
}
