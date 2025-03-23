// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cart_product_ca_app/core/constants/route_constant.dart';
import 'package:cart_product_ca_app/features/cart/data/models/cart_model.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_bloc.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cart_product_ca_app/core/extensions/color_extension.dart';
import 'package:cart_product_ca_app/core/extensions/text_extension.dart';
import 'package:cart_product_ca_app/core/themes/app_pallete.dart';
import 'package:cart_product_ca_app/core/utils/decoration.dart';
import 'package:cart_product_ca_app/di/service_locator.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
import 'package:cart_product_ca_app/features/product/presentations/bloc/product_bloc.dart';
import 'package:cart_product_ca_app/features/product/presentations/bloc/product_event.dart';
import 'package:cart_product_ca_app/features/product/presentations/bloc/product_state.dart';

import '../../../../core/utils/size.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage(
      {super.key, required this.productId, required this.previousePage});
  final int productId;
  final String previousePage;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = sl<ProductBloc>();
    _productBloc.add(GetProductByIdEvent(productID: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (widget.previousePage == RouteConstant.cart) {
            context.read<CartBloc>().add(GetCartItemsEvent());
            await Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteConstant.cart, (route) => false);
            return false;
          }

          return true;
        },
        child: Scaffold(
          body: BlocProvider.value(
            value: _productBloc,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoadingState) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ProductLoadedState) {
                  final ProductEntity product = state.product;
                  return Scaffold(
                    appBar: ProductImageWidget(
                      previousePage: widget.previousePage,
                      context: context,
                      product: product,
                    ),
                    body: DetailsWidget(
                      product: product,
                    ),
                    bottomNavigationBar: BottomWidget(
                      product: state.product,
                    ),
                  );
                } else if (state is ProductFailureState) {
                  return Center(child: Text(state.failure.message));
                }

                return Center(
                  child: Text("No Data Available"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsWidget extends StatefulWidget {
  DetailsWidget({
    super.key,
    required this.product,
  });

  final ProductEntity product;
  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  void incrementQuantity() {
    context.read<CartBloc>().quantity++;

    setState(() {});
  }

  void decrementQuantity() {
    if (context.read<CartBloc>().quantity > 1) {
      context.read<CartBloc>().quantity--;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.product.title,
                style: context.bodyMediumText.copyWith(
                    color: AppPallete.blackColor, fontWeight: FontWeight.w500),
              ),
            ),
            RatingWidget(product: widget.product),
          ],
        ),
        gap(gap: 10.0),
        Text(
          widget.product.category.toLowerCase(),
          style: context.bodySmallText.copyWith(color: context.primaryColor),
        ),
        gap(gap: size(context).height * 0.08),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QuantityCircaleButton(
                  tap: () {
                    incrementQuantity();
                  },
                  icon: Icons.add,
                ),
                gap(gap: 18.0),
                Text(
                  context.read<CartBloc>().quantity.toString(),
                  style: context.bodyLargeText
                      .copyWith(color: AppPallete.greyColor, fontSize: 20),
                ),
                gap(gap: 18.0),
                QuantityCircaleButton(
                  tap: () {
                    decrementQuantity();
                  },
                  icon: Icons.remove,
                ),
              ],
            ),
            gap(),
            Text(
              "Quantity",
              style:
                  context.bodySmallText.copyWith(color: AppPallete.blackColor),
            )
          ],
        ),
      ],
    );
  }
}

class QuantityCircaleButton extends StatelessWidget {
  const QuantityCircaleButton({
    super.key,
    required this.tap,
    required this.icon,
  });
  final GestureTapCallback tap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: AppPallete.greyColor)),
      child: InkWell(
          onTap: tap,
          child: Icon(
            icon,
            color: AppPallete.greyColor,
            size: 15,
          )),
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    // Get the CartBloc instance once
    final cartBloc = context.read<CartBloc>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 90,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(12), // Optional: Add rounded corners
        color: AppPallete.whiteColor, // Optional: Add background color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Product price details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price:",
                style: context.bodyMediumText.copyWith(
                  color: AppPallete.greyColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4), // Space between text elements
              Text(
                "\$ ${product.price}",
                style: context.h3.copyWith(
                  color: AppPallete.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Add to cart button
          ElevatedButton(
            onPressed: () {
              final cartItem = CartItemModel(
                name: product.title,
                price: product.price,
                quantity: cartBloc.quantity, // Access quantity once
                id: product.id,
                image: product.image,
              );

              // Add to cart event
              cartBloc.add(AddCartItemEvent(cartItem: cartItem));

              // Print the cart item details
              print(cartItem.toMap());

              cartBloc.add(UpdateQuantity(quantity: 1));
            },
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(AppPallete.whiteColor),
              fixedSize: WidgetStateProperty.all(Size(160, 65)),
              backgroundColor: WidgetStateProperty.all(AppPallete.blackColor),
            ),
            child: Text(
              "🛍️ Add to cart",
              style: context.bodySmallText.copyWith(
                color: AppPallete.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: radius(radius: 15.0),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.topCenter,
              colors: [Colors.orange, context.primaryColor])),
      child: Text(
        "⭐ ${product.rating.rate}",
        style: context.bodySmallText
            .copyWith(color: AppPallete.whiteColor, fontSize: 10.0),
      ),
    );
  }
}

class ProductImageWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductImageWidget(
      {super.key,
      required this.product,
      required this.context,
      required this.previousePage});
  final ProductEntity product;
  final BuildContext context;
  final String previousePage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context).height * 0.45,
      color: AppPallete.whiteColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () async {
                      if (previousePage == RouteConstant.cart) {
                        context.read<CartBloc>().add(GetCartItemsEvent());
                        await Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteConstant.cart, (route) => false);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Text(
                  "Detail Item",
                  style: context.bodySmallText,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border_outlined))
              ],
            ),
          ),
          Image.network(
            height: size(context).height * 0.35,
            product.image,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size(context).height * 0.5);
}
