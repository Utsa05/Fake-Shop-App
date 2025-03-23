// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/core/params/no_param.dart';
import 'package:cart_product_ca_app/core/usecase/uscase.dart';
import 'package:cart_product_ca_app/features/cart/domain/entities/cart_entitiy.dart';
import 'package:cart_product_ca_app/features/cart/domain/repositories/cart_local_respository.dart';
import 'package:dartz/dartz.dart';

class GetCartItem extends UseCase<List<CartItem>, NoParam> {
  final CartLocalRespository cartLocalRespository;
  GetCartItem({
    required this.cartLocalRespository,
  });

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParam param) async {
    final data = await cartLocalRespository.getCartItems();
    return data;
  }
}
