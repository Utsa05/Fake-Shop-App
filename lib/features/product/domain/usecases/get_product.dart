// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/core/usecase/uscase.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
import 'package:cart_product_ca_app/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProduct extends UseCase<ProductEntity, int> {
  final ProductRepository productRepository;
  GetProduct({
    required this.productRepository,
  });

  @override
  Future<Either<Failure, ProductEntity>> call(int param) async {
    return await productRepository.getProductById(param);
  }
}
