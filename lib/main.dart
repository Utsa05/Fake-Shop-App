import 'package:cart_product_ca_app/app.dart';
import 'package:cart_product_ca_app/di/service_locator.dart';
// import 'package:cart_product_ca_app/features/home/domain/usecases/get_product.dart';
// import 'package:cart_product_ca_app/core/client/api_client.dart';
// import 'package:cart_product_ca_app/core/error/failure.dart';
// import 'package:cart_product_ca_app/core/params/no_param.dart';
// import 'package:cart_product_ca_app/features/home/data/datasources/home_datasource.dart';
// import 'package:cart_product_ca_app/features/home/data/repositories/home_repository_impl.dart';
// import 'package:cart_product_ca_app/features/home/domain/entities/product_entity.dart';
// import 'package:cart_product_ca_app/features/home/domain/repositories/home_repository.dart';
// import 'package:cart_product_ca_app/features/home/domain/usecases/get_product.dart';
import 'package:flutter/material.dart';

// import 'package:http/http.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized

  //call locator
  try {
    await serviceLocatorInit(); // Ensure service locator initialization completes
  } catch (e) {
    print('Service Locator Initialization Error: $e');
  }

  // AuthRegisterUser getProduct = sl<AuthRegisterUser>();
  // Either<Failure, AuthRegisterResposneModel> products = await getProduct(
  //     AuthRegisterResposneModel(
  //         id: 1,
  //         username: "John Smiht",
  //         email: "John@gmail.com",
  //         password: "password"));
  // products.fold((l) => print(l), (r) {
  //   print(r);
  // });

  //!raw
  // ApiClient apiClient = ApiClient(client: Client());
  // HomeDatasource datasource = HomeDatasourceImpl(apiClient: apiClient);
  // HomeRepository repository = HomeRepositoryImpl(homeDatasource: datasource);
  // GetProduct getProduct = GetProduct(homeRepository: repository);
  // Either<Failure, List<ProductEntity>> products = await getProduct(NoParam());
  // products.fold((l) => print(l), (r) {
  //   print(r);
  // });
  runApp(const App());
}
