// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/core/usecase/uscase.dart';
import 'package:cart_product_ca_app/features/cart/domain/repositories/cart_local_respository.dart';
import 'package:dartz/dartz.dart';

class DeleteCartItem extends UseCase<void, int> {
  final CartLocalRespository cartLocalRespository;
  DeleteCartItem({
    required this.cartLocalRespository,
  });

  @override
  Future<Either<Failure, void>> call(int param) {
    return cartLocalRespository.removeCartItem(param);
  }
}
