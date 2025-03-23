abstract class ProductEvent {}

class InitEvent extends ProductEvent {}

class GetProductByIdEvent extends ProductEvent {
  final int productID;

  GetProductByIdEvent({required this.productID});
}
