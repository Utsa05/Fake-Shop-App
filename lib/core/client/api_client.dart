import 'dart:convert';
import 'package:cart_product_ca_app/core/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient({required http.Client client}) : _client = client;

  Future<dynamic> get(String path) async {
    final String url = ApiConstant.baseUrl + path; // Using dynamic path

    final header = {"Content-Type": "application/json"};

    final response = await _client.get(Uri.parse(url), headers: header);

    // Check if the response is successful
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> post(String path,
      {dynamic data, bool isNeedToken = false}) async {
    final String url = ApiConstant.baseUrl + path; // Constructing the URL

    // Dynamic token retrieval (replace with actual method to get the token)
    String token = "your_actual_token_here";

    final headers = {
      "Content-Type": "application/json",
      if (isNeedToken) "Authorization": "Bearer $token",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data != null
            ? jsonEncode(data)
            : null, // Ensure proper JSON encoding
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      throw Exception("Request failed: $e");
    }
  }
}
