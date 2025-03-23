// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cart_product_ca_app/core/params/no_param.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/add_cart_item.dart';

import 'package:cart_product_ca_app/features/cart/domain/usecases/clear_cart_items.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/delete_cart_item.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/get_cart_item.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/update_cart_item.dart';
import 'package:flutter/material.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItem _getCartItem;
  final DeleteCartItem _deleteCartItem;
  final ClearCartItems _clearCartItems;
  final UpdateCartItem _updateCartItem;
  final AddCartItem _addCartItem;

  int quantity = 1;

  CartBloc(
    this._getCartItem,
    this._deleteCartItem,
    this._clearCartItems,
    this._updateCartItem,
    this._addCartItem,
  ) : super(CartState()) {
    on<GetCartItemsEvent>(_initGetCartItems);
    on<AddCartItemEvent>(_initAddCartItem);
    on<RemoveItemEvent>(_initRemoveCartItem);
    on<UpdateCartItemEvent>(_initUpdateCartItem);
    on<ClearCartItemsEvent>(_initClearsCartItems);
    on<UpdateQuantity>(_initUpdateQuantity);
  }

  void _initGetCartItems(
      GetCartItemsEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    final result = await _getCartItem.call(NoParam());
    result.fold(
      (error) => emit(CartFailureState(failure: error)),
      (cart) => emit(CartLoadedState(cartItems: cart)),
    );
  }

  void _initAddCartItem(AddCartItemEvent event, Emitter<CartState> emit) async {
    await _addCartItem.call(event.cartItem);
    add(GetCartItemsEvent());
    debugPrint("success fully added to cart");
  }

  void _initRemoveCartItem(
      RemoveItemEvent event, Emitter<CartState> emit) async {
    await _deleteCartItem.call(event.productId);
    add(GetCartItemsEvent()); // Refresh cart items after removal
  }

  void _initUpdateCartItem(
      UpdateCartItemEvent event, Emitter<CartState> emit) async {
    await _updateCartItem.call(event.cartItemModel);
    add(GetCartItemsEvent());
    print("UPDATED Cart");
  }

  void _initClearsCartItems(
      ClearCartItemsEvent event, Emitter<CartState> emit) async {
    await _clearCartItems.call(NoParam());
    add(GetCartItemsEvent());
  }

  void _initUpdateQuantity(UpdateQuantity event, Emitter<CartState> emite) {
    quantity = 1;
  }
}
