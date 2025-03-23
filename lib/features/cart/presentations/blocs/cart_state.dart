import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/cart/data/models/cart_model.dart';
import 'package:cart_product_ca_app/features/cart/domain/entities/cart_entitiy.dart';

class CartState {
  CartState clone() {
    return CartState();
  }
}

//common
class CartLoadingState extends CartState {}

class CartFailureState extends CartState {
  final Failure failure;

  CartFailureState({required this.failure});
}

//get carts
class CartLoadedState extends CartState {
  final List<CartItem> cartItems;
  final double totalPrice;
  int x = 0;

  CartLoadedState({required this.cartItems})
      : totalPrice = cartItems.fold(
            0, (sum, item) => sum + (item.price * item.quantity));
}

class CartItemCountUpdatedState extends CartState {
  final int cartItemCount;

  CartItemCountUpdatedState({required this.cartItemCount});
}

//update
class CartItemUpdatedState extends CartState {}

//clear
class CartItemClearedState extends CartState {}

//remove
class CartItemRemovedState extends CartState {}
