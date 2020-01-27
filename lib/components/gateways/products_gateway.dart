import 'package:elo_7/components/gateways/products_gateway_contract.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsGateway extends ProductsGatewayContract {
  final String _baseEndPoint =
      'https://5dc05c0f95f4b90014ddc651.mockapi.io/elo7/api/1/';

  @override
  Future<Iterable<Map<String, dynamic>>> fetchProducts() =>
      http.get('$_baseEndPoint\products').then(
        (response) {
          if (response.statusCode == 200) {
            return json.decode(response.body).cast<Map<String, dynamic>>();
          }
          throw Exception();
        },
      );

  @override
  Future<Iterable<Map<String, dynamic>>> fetchSearchProducts({String text}) =>
      http.get('$_baseEndPoint\products?q=$text').then(
        (response) {
          if (response.statusCode == 200) {
            return json
                .decode(utf8.decode(response.bodyBytes))
                .cast<Map<String, dynamic>>();
          }
          throw Exception();
        },
      );

  Map<String, dynamic> parseJson(String response) =>
      json.decode(response).cast<Map<String, dynamic>>();
}
