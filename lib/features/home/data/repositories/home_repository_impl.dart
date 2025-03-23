import 'dart:io';

import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/home/data/datasources/home_datasource.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
import 'package:cart_product_ca_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDatasource _homeDatasource;

  HomeRepositoryImpl({required HomeDatasource homeDatasource})
      : _homeDatasource = homeDatasource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await _homeDatasource.getProducts();
      return right(products);
    } on SocketException {
      return left(Failure(message: "No Internet Connection"));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
