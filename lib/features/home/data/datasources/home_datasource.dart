import 'package:cart_product_ca_app/core/client/api_client.dart';
import 'package:cart_product_ca_app/core/constants/api_constant.dart';
import 'package:cart_product_ca_app/features/home/data/models/product_model.dart';

abstract class HomeDatasource {
  Future<List<ProductModel>> getProducts();
}

class HomeDatasourceImpl extends HomeDatasource {
  final ApiClient _apiClient;

  HomeDatasourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _apiClient.get(ApiConstant.products);
    List<dynamic> resposneList = response;
    List<ProductModel> products =
        resposneList.map((product) => ProductModel.fromJson(product)).toList();
    return products;
  }
}
