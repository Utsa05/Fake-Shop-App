import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:cart_product_ca_app/features/cart/data/models/cart_model.dart';
import 'package:cart_product_ca_app/features/cart/domain/repositories/cart_local_respository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/cart_entitiy.dart';

class CarlLocalRepositoryImpl extends CartLocalRespository {
  final CartLocalDataSource _cartLocalDataSource;

  CarlLocalRepositoryImpl({required CartLocalDataSource cartLocalDataSource})
      : _cartLocalDataSource = cartLocalDataSource;

  @override
  Future<Either<Failure, Future<void>>> addCartItem(CartItemModel item) async {
    try {
      final result = _cartLocalDataSource.addCartItem(item);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Future<void>>> clearCart() async {
    try {
      final result = _cartLocalDataSource.clearCart();
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final result = await _cartLocalDataSource.getCartItems();
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Future<void>>> removeCartItem(int id) async {
    try {
      final result = _cartLocalDataSource.removeCartItem(id);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Future<void>>> updateCartItem(
      CartItemModel item) async {
    try {
      final result = _cartLocalDataSource.updateCartItem(item);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
