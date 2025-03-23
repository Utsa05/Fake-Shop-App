import 'package:cart_product_ca_app/core/client/api_client.dart';
import 'package:cart_product_ca_app/core/constants/api_constant.dart';
import 'package:cart_product_ca_app/features/home/data/models/product_model.dart';

abstract class ProductDatasource {
  Future<ProductModel> getProductByID(int productId);
}

class ProductDatasourceImpl extends ProductDatasource {
  final ApiClient _apiClient;

  ProductDatasourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<ProductModel> getProductByID(int productId) async {
    final response =
        await _apiClient.get(ApiConstant.product(id: productId.toString()));

    ProductModel product = ProductModel.fromJson(response);

    return product;
  }
}
