import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/cart/domain/entities/cart_entitiy.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/cart_model.dart';

abstract class CartLocalRespository {
  Future<Either<Failure, List<CartItem>>> getCartItems();
  Future<Either<Failure, void>> addCartItem(CartItemModel item);
  Future<Either<Failure,void>> updateCartItem(CartItemModel item);
  Future<Either<Failure,void>> removeCartItem(int id);
  Future<Either<Failure, void>> clearCart();
}
