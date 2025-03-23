import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';

class HomeState {
  HomeState clone() {
    return HomeState();
  }
}

class ProductLoadingHomeState extends HomeState {}

class ProductLoadedHomeState extends HomeState {
  final List<ProductEntity> products;

  ProductLoadedHomeState({required this.products});
}

class FailurLoadPorductHomeState extends HomeState {
  final Failure failure;

  FailurLoadPorductHomeState({required this.failure});
}
