import 'dart:io';

import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
import 'package:cart_product_ca_app/features/product/data/datasources/product_datasource.dart';
import 'package:cart_product_ca_app/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDatasource _productDatasource;

  ProductRepositoryImpl({required ProductDatasource productDatasource})
      : _productDatasource = productDatasource;

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int productId) async {
    try {
      final product = await _productDatasource.getProductByID(productId);
      return right(product);
    } on SocketException {
      return left(Failure(message: "No Internet Connection"));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
