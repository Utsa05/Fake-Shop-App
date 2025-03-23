import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getProductById(int productId);
}
