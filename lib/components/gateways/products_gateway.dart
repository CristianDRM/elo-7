import 'package:elo_7/components/gateways/products_gateway_contract.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:meta/meta.dart';

class ProductsGateway extends ProductsGatewayContract {
  ProductsGateway({@required this.client}) : assert(client != null);
  final Client client;

  final String _baseEndPoint =
      'https://5dc05c0f95f4b90014ddc651.mockapi.io/elo7/api/1/';

  @override
  Future<Iterable<Map<String, dynamic>>> fetchProducts() =>
      client.get('$_baseEndPoint\products').then(
        (response) {
          if (response.statusCode == 200) {
            return json.decode(response.body).cast<Map<String, dynamic>>();
          }
          throw Exception();
        },
      );

  @override
  Future<Iterable<Map<String, dynamic>>> fetchSearchProducts({String text}) =>
      client.get('$_baseEndPoint\products?q=$text').then(
        (response) {
          if (response.statusCode == 200) {
            return json
                .decode(utf8.decode(response.bodyBytes))
                .cast<Map<String, dynamic>>();
          }
          throw Exception();
        },
      );
}
