import 'package:cart_product_ca_app/core/constants/route_constant.dart';
import 'package:cart_product_ca_app/core/themes/app_theme.dart';
import 'package:cart_product_ca_app/di/service_locator.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_bloc.dart';
import 'package:cart_product_ca_app/features/home/presentations/bloc/home_bloc.dart';
import 'package:cart_product_ca_app/features/home/presentations/pages/home_page.dart';
import 'package:cart_product_ca_app/features/product/presentations/bloc/product_bloc.dart';
import 'package:cart_product_ca_app/on_generate_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => sl<HomeBloc>()),
        BlocProvider(create: (create) => sl<ProductBloc>()),
        BlocProvider(create: (create) => sl<CartBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        initialRoute: RouteConstant.initial,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
