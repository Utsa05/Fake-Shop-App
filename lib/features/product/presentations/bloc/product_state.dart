import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';

class ProductState {
  ProductState clone() {
    return ProductState();
  }
}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final ProductEntity product;

  ProductLoadedState({required this.product});
}

class ProductFailureState extends ProductState {
  final Failure failure;

  ProductFailureState({required this.failure});
}
