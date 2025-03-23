import 'package:cart_product_ca_app/core/client/api_client.dart';
import 'package:cart_product_ca_app/core/constants/api_constant.dart';
import 'package:cart_product_ca_app/features/auth/data/models/auth_register_response_model.dart';

abstract class AuthDatasource {
  Future<AuthRegisterResposneModel> registerNewUser(
      AuthRegisterResposneModel param);
}

class AutheDatasourceImpl extends AuthDatasource {
  final ApiClient _apiClient;

  AutheDatasourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  @override
  Future<AuthRegisterResposneModel> registerNewUser(
      AuthRegisterResposneModel param) async {
    print("HI");
    final response =
        await _apiClient.post(ApiConstant.register, data: param.toJson());

    final check = AuthRegisterResposneModel(
        id: response["id"],
        username: param.username,
        email: param.email,
        password: param.password);
    AuthRegisterResposneModel authUser =
        AuthRegisterResposneModel.fromJson(check.toJson());

    return authUser;
  }
}
