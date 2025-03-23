import 'package:cart_product_ca_app/core/constants/route_constant.dart';
import 'package:cart_product_ca_app/core/extensions/color_extension.dart';
import 'package:cart_product_ca_app/core/extensions/text_extension.dart';
import 'package:cart_product_ca_app/core/themes/app_pallete.dart';
import 'package:cart_product_ca_app/core/utils/decoration.dart';
import 'package:cart_product_ca_app/core/utils/size.dart';
import 'package:cart_product_ca_app/di/service_locator.dart';
import 'package:cart_product_ca_app/features/cart/data/models/cart_model.dart';
import 'package:cart_product_ca_app/features/cart/domain/entities/cart_entitiy.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_bloc.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_event.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/presentations/pages/product_details.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartBloc _cartBloc;

  @override
  void initState() {
    _cartBloc = sl<CartBloc>();
    _cartBloc.add(GetCartItemsEvent());
    super.initState();
  }

  int _discountCalculate(int len) {
    if (len < 2) {
      return 0;
    } else if (len >= 2 && len <= 5) {
      return 3;
    } else if (len >= 6 && len <= 10) {
      return 5;
    } else {
      return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cartAppbar(context),
      body: BlocProvider.value(
        value: _cartBloc,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadedState) {
              return state.cartItems.isNotEmpty
                  ? _CartView(state)
                  : Center(
                      child: Text("Empty Cart"),
                    );
            } else if (state is CartLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartFailureState) {
              return Center(
                child: Text(state.failure.message),
              );
            }

            return Center(
              child: Text("OPS"),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 130,
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
        child: BlocProvider.value(
          value: _cartBloc,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SummaryRowWidget(
                      titel: "Items",
                      value: "\$ ${state.totalPrice.toStringAsFixed(2)}",
                    ),
                    gap(),
                    SummaryRowWidget(
                      titel: "Discounts",
                      value:
                          "- \$ ${_discountCalculate(state.cartItems.length).toString()}",
                    ),
                    gap(),
                    Divider(
                      thickness: 1,
                      height: 1,
                      color: AppPallete.greyColor.withAlpha(40),
                    ),
                    gap(),
                    SummaryRowWidget(
                      titel: "Total",
                      value:
                          "\$ ${(state.totalPrice - _discountCalculate(state.cartItems.length)).toStringAsFixed(2)}",
                    ),
                  ],
                );
              } else if (state is CartLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartFailureState) {
                return Center(
                  child: Text(state.failure.message),
                );
              }

              return Container(
                child: Text("OPS"),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar cartAppbar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: AppPallete.transparentColor,
      centerTitle: true,
      title: Text(
        "Your Cart",
        style: context.bodyMediumText.copyWith(
            color: AppPallete.blackColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w600),
      ),
      iconTheme: IconThemeData(color: AppPallete.blackColor),
    );
  }
}

class SummaryRowWidget extends StatelessWidget {
  const SummaryRowWidget({
    super.key,
    required this.titel,
    required this.value,
  });
  final String titel;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titel,
            style: context.bodyMediumText
                .copyWith(color: AppPallete.greyColor, fontSize: 15.0),
          ),
        ),
        Text(
          value,
          style: context.bodyLargeText
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
        )
      ],
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView(this.state);
  final CartLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
      width: size(context).width,
      height: size(context).height,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            decoration: BoxDecoration(
              borderRadius: radius(radius: 24.0),
              color: context.primaryColor.withAlpha(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 20.0,
                  color: context.primaryColor,
                ),
                gap(),
                Text(
                  "You have ${state.cartItems.length} items in you list chart",
                  style: context.bodySmallText
                      .copyWith(color: context.primaryColor, fontSize: 12),
                )
              ],
            ),
          ),
          gap(gap: 20.0),
          CartList(state: state),
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({
    super.key,
    required this.state,
  });

  final CartLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: state.cartItems.length,
          itemBuilder: (context, index) {
            final CartItem cart = state.cartItems[index];
            return CartListITem(cart: cart);
          }),
    );
  }
}

class CartListITem extends StatelessWidget {
  const CartListITem({
    super.key,
    required this.cart,
  });

  final CartItem cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 1.5),
      decoration: BoxDecoration(color: AppPallete.whiteColor, boxShadow: [
        BoxShadow(
          color: AppPallete.blackColor.withAlpha(10),
          offset: Offset(0, 2), // Moves the shadow down
        )
      ]),
      child: ListTile(
        onTap: () async {
          //  context.read<CartBloc>().add(GetCartItemsEvent());
          Navigator.of(context).pushNamed(RouteConstant.prodcutDetails,
              arguments: {"id": cart.id, "page": RouteConstant.cart});
        },
        shape: RoundedRectangleBorder(borderRadius: radius()),
        // tileColor: AppPallete.blackColor.withAlpha(5),
        leading: Image.network(
          cart.image,
          height: size(context).height * 0.1,
          fit: BoxFit.contain,
          width: size(context).height * 0.1,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    cart.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmallText
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                gap(gap: 4.0),
                GestureDetector(
                    onTap: () {
                      context
                          .read<CartBloc>()
                          .add(RemoveItemEvent(productId: cart.id!.toInt()));
                    },
                    child: Icon(
                      Icons.delete,
                      color: AppPallete.greyColor,
                      size: 17,
                    ))
              ],
            ),
            gap(gap: 5.0),
            Text(
              "Manfashion",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodySmallText.copyWith(
                  color: AppPallete.greyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 10),
            ),
          ],
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "\$ ${cart.price}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySmallText.copyWith(
                      color: AppPallete.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 27,
                    width: 27,
                    child: QuantityCircaleButton(
                      tap: () {
                        int quantiy = cart.quantity + 1;
                        context.read<CartBloc>().add(UpdateCartItemEvent(
                            cartItemModel: CartItemModel(
                                id: cart.id,
                                name: cart.name,
                                price: cart.price,
                                quantity: quantiy,
                                image: cart.image)));
                      },
                      icon: Icons.add,
                    ),
                  ),
                  gap(gap: 10.0),
                  Text(
                    cart.quantity.toString(),
                    style: context.bodyLargeText
                        .copyWith(color: AppPallete.greyColor, fontSize: 15),
                  ),
                  gap(gap: 10.0),
                  SizedBox(
                    height: 27,
                    width: 27,
                    child: QuantityCircaleButton(
                      tap: () {
                        int quantiy = cart.quantity - 1;
                        context.read<CartBloc>().add(UpdateCartItemEvent(
                            cartItemModel: CartItemModel(
                                id: cart.id,
                                name: cart.name,
                                price: cart.price,
                                quantity: quantiy,
                                image: cart.image)));
                      },
                      icon: Icons.remove,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
