class ApiConstant {
  const ApiConstant._();

  //product
  static const String baseUrl = "https://fakestoreapi.com/";
  static const String products = "products";
  static String product({required String id}) => "products/$id";

  //user
  static const String register = "users";
}
