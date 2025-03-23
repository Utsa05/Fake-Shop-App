import 'package:cart_product_ca_app/core/constants/route_constant.dart';
import 'package:cart_product_ca_app/core/extensions/color_extension.dart';
import 'package:cart_product_ca_app/core/extensions/text_extension.dart';
import 'package:cart_product_ca_app/core/themes/app_pallete.dart';
import 'package:cart_product_ca_app/core/utils/decoration.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_event.dart';
import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
import 'package:cart_product_ca_app/features/home/presentations/bloc/home_bloc.dart';
import 'package:cart_product_ca_app/features/home/presentations/bloc/home_event.dart';
import 'package:cart_product_ca_app/features/home/presentations/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/size.dart';
import '../../../cart/presentations/blocs/cart_bloc.dart';
import '../../../cart/presentations/blocs/cart_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  late CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>();
    _cartBloc = context.read<CartBloc>();

    _homeBloc.add(GetProductHomeEvent());
    _cartBloc.add(GetCartItemsEvent()); // Get cart items initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Shop"),
        actions: [
          GestureDetector(
            onTap: () async {
              await Navigator.of(context).pushNamed(RouteConstant.cart);
              _cartBloc.add(GetCartItemsEvent()); // Refresh cart when returning
            },
            child: Badge(
              smallSize: 20,
              isLabelVisible: true,
              label: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  int cartItemCount = 0;
                  if (cartState is CartLoadedState) {
                    cartItemCount = cartState.cartItems.length;
                  }

                  return Text(
                    cartItemCount.toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 20,
                color: AppPallete.whiteColor,
              ),
            ),
          ),
          gap(),
          IconButton(
            splashColor: AppPallete.whiteColor,
            onPressed: () {
              // Refresh cart when returning
            },
            icon: Icon(
              Icons.search_outlined,
              color: AppPallete.whiteColor,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _homeBloc.add(GetProductHomeEvent());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is ProductLoadingHomeState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FailurLoadPorductHomeState) {
              return Text(state.failure.message);
            } else if (state is ProductLoadedHomeState) {
              return productGrid(context, state.products, _cartBloc);
            }
            return Center(child: Text("OOPS!"));
          },
        ),
      ),
    );
  }
}

Widget productGrid(
    BuildContext context, List<ProductEntity> products, CartBloc cartBloc) {
  return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 185,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0),
      itemBuilder: (context, index) {
        final ProductEntity product = products[index];
        return GestureDetector(
            onTap: () {
             Navigator.of(context).pushNamed(RouteConstant.prodcutDetails,
              arguments: {"id": product.id, "page": RouteConstant.home});

              context.read<CartBloc>().add(GetCartItemsEvent());
            },
            child: productItemWidget(product, context));
      });
}

Widget productItemWidget(ProductEntity product, BuildContext c) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        color: AppPallete.whiteColor,
        borderRadius: radius(),
        border: Border.all(
            width: 1.0, color: AppPallete.greyColor.withOpacity(0.2))),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              product.image,
              width: 80,
              height: 80,
            ),
            gap(gap: 15.0),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${product.category}   (${product.rating.count.toString()})⭐",
                    style: c.bodySmallText.copyWith(
                        color: c.primaryColor,
                        fontSize: 8.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                gap(),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: c.bodySmallText
                      .copyWith(fontSize: 11.0, color: AppPallete.blackColor),
                ),
              ],
            )
          ],
        ),
        Positioned(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration:
              BoxDecoration(borderRadius: radius(), color: c.primaryColor),
          child: Text(
            "\$ ${product.price.toString()}",
            style: c.bodySmallText
                .copyWith(color: AppPallete.whiteColor, fontSize: 8.0),
          ),
        ))
      ],
    ),
  );
}
