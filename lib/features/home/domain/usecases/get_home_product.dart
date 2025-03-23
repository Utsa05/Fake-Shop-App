// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/core/params/no_param.dart';
import 'package:cart_product_ca_app/core/usecase/uscase.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
import 'package:cart_product_ca_app/features/home/domain/repositories/home_repository.dart';

class GetHomeProduct extends UseCase<List<ProductEntity>, NoParam> {
  final HomeRepository homeRepository;
  GetHomeProduct({
    required this.homeRepository,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParam param) async {
    return await homeRepository.getProducts();
  }
}
