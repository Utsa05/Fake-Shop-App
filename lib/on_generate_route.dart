import 'package:cart_product_ca_app/core/constants/route_constant.dart';
import 'package:cart_product_ca_app/features/cart/presentations/pages/cart_page.dart';
import 'package:cart_product_ca_app/features/home/presentations/pages/home_page.dart';
import 'package:cart_product_ca_app/features/product/presentations/pages/product_details.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    final arg = setting.arguments;
    final Map<String, dynamic>? argMap =
        setting.arguments as Map<String, dynamic>?;

    switch (setting.name) {
      case RouteConstant.initial:
        return _pageRoute(HomePage());
      case RouteConstant.prodcutDetails:
        int id = argMap?["id"];
        String previousePage = argMap?["page"];
        return _pageRoute(ProductDetailsPage(
          previousePage: previousePage,
          productId: id,
        ));
      case RouteConstant.cart:
        return _pageRoute(CartPage());
      default:
        return _pageRoute(RouteErrorPage());
    }
  }
}

MaterialPageRoute _pageRoute(Widget page) =>
    MaterialPageRoute(builder: (builder) => page);

class RouteErrorPage extends StatelessWidget {
  const RouteErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Routes"),
      ),
    );
  }
}
