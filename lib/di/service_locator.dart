import 'package:cart_product_ca_app/core/client/api_client.dart';
import 'package:cart_product_ca_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:cart_product_ca_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cart_product_ca_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cart_product_ca_app/features/auth/domain/usecases/auth_register_user.dart';
import 'package:cart_product_ca_app/features/auth/presentations/blocs/auth_bloc.dart';
import 'package:cart_product_ca_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:cart_product_ca_app/features/cart/data/repositories/carl_local_repository_impl.dart';
import 'package:cart_product_ca_app/features/cart/domain/repositories/cart_local_respository.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/add_cart_item.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/clear_cart_items.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/delete_cart_item.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/get_cart_item.dart';
import 'package:cart_product_ca_app/features/cart/domain/usecases/update_cart_item.dart';
import 'package:cart_product_ca_app/features/cart/presentations/blocs/cart_bloc.dart';
import 'package:cart_product_ca_app/features/home/data/datasources/home_datasource.dart';
import 'package:cart_product_ca_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:cart_product_ca_app/features/home/domain/repositories/home_repository.dart';
import 'package:cart_product_ca_app/features/home/domain/usecases/get_home_product.dart';
import 'package:cart_product_ca_app/features/home/presentations/bloc/home_bloc.dart';
import 'package:cart_product_ca_app/features/product/data/datasources/product_datasource.dart';
import 'package:cart_product_ca_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:cart_product_ca_app/features/product/domain/repositories/product_repository.dart';
import 'package:cart_product_ca_app/features/product/domain/usecases/get_product.dart';
import 'package:cart_product_ca_app/features/product/presentations/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.I;

Future<void> serviceLocatorInit() async {
  //global
  sl.registerLazySingleton<Client>(() => Client()); //http
  sl.registerLazySingleton<ApiClient>(
      () => ApiClient(client: sl())); //http - client

  //auth
  _intiAuth();
  //home
  _homeInit();

  //product
  _productInit();

  //cart
  await _cartInit();
}

//home
void _homeInit() {
  //data source
  sl.registerLazySingleton<HomeDatasource>(
      () => HomeDatasourceImpl(apiClient: sl()));
  //repositores
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeDatasource: sl()));
  //usecase
  sl.registerLazySingleton<GetHomeProduct>(
      () => GetHomeProduct(homeRepository: sl()));

  //blocs
  sl.registerFactory(() => HomeBloc(sl()));
}

//auth
_intiAuth() {
  sl.registerLazySingleton<AuthDatasource>(
      () => AutheDatasourceImpl(apiClient: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: sl()));
  sl.registerLazySingleton<AuthRegisterUser>(
      () => AuthRegisterUser(authRepository: sl()));

  sl.registerFactory(() => AuthBloc(sl()));
}

//product
void _productInit() {
  //data source
  sl.registerLazySingleton<ProductDatasource>(
      () => ProductDatasourceImpl(apiClient: sl()));
  //repositores
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productDatasource: sl()));
  //usecase
  sl.registerLazySingleton<GetProduct>(
      () => GetProduct(productRepository: sl()));

  //blocs
  sl.registerFactory(() => ProductBloc(sl()));
}

//cart
Future<void> _cartInit() async {
  print("Initializing Cart Database...");
  final database = await openDatabase(
    'cart.db',
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE cart(id INTEGER PRIMARY KEY, name TEXT, image TEXT, price REAL, quantity INTEGER)');
    },
  );

  print("Registering dependencies...");
  sl.registerLazySingleton<Database>(() => database);
  sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(database: sl()));
  sl.registerLazySingleton<CartLocalRespository>(
      () => CarlLocalRepositoryImpl(cartLocalDataSource: sl()));

  sl.registerFactory<GetCartItem>(
      () => GetCartItem(cartLocalRespository: sl()));
  sl.registerLazySingleton<UpdateCartItem>(
      () => UpdateCartItem(cartLocalRespository: sl()));
  sl.registerLazySingleton<AddCartItem>(
      () => AddCartItem(cartLocalRespository: sl()));
  sl.registerLazySingleton<DeleteCartItem>(
      () => DeleteCartItem(cartLocalRespository: sl()));
  sl.registerLazySingleton<ClearCartItems>(
      () => ClearCartItems(cartLocalRespository: sl()));

  sl.registerFactory<CartBloc>(() => CartBloc(sl(), sl(), sl(), sl(), sl()));

}
