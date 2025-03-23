import 'package:cart_product_ca_app/features/cart/data/models/cart_model.dart';
import "package:equatable/equatable.dart";

abstract class CartEvent extends Equatable {}

class InitEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class GetCartItemsEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class AddCartItemEvent extends CartEvent {
  final CartItemModel cartItem;

  AddCartItemEvent({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class UpdateCartItemEvent extends CartEvent {
  final CartItemModel cartItemModel;

  UpdateCartItemEvent({required this.cartItemModel});

  @override
  List<Object?> get props => [cartItemModel];
}

class RemoveItemEvent extends CartEvent {
  final int productId;

  RemoveItemEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class ClearCartItemsEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class UpdateQuantity extends CartEvent {
  final int quantity;

  UpdateQuantity({required this.quantity});
  
  @override
  List<Object?> get props => [quantity];
}
