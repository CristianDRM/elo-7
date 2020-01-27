import 'package:elo_7/components/gateways/products_gateway.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('#fetchProducts', () {
    test('when status code is 200 then emits response body', () {
      final responseBody = [
        {'id': 123}
      ];
      final Client client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://5dc05c0f95f4b90014ddc651.mockapi.io/elo7/api/1/products',
        );
        return Response(json.encode(responseBody), 200);
      });

      final ProductsGateway gateway = ProductsGateway(client: client);
      expect(gateway.fetchProducts(), completion(responseBody));
    });
    test('when status code is not 200 then throws error', () {
      final Client client = MockClient((request) async {
        return Response(json.encode([]), 500);
      });

      final ProductsGateway gateway = ProductsGateway(client: client);
      expect(gateway.fetchProducts(), throwsException);
    });
  });

  group('#fetchSearchProducts', () {
    test('when status code is 200 then emits response body', () {
      final responseBody = [
        {'id': 123}
      ];
      final Client client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://5dc05c0f95f4b90014ddc651.mockapi.io/elo7/api/1/products?q=FooBar',
        );
        return Response(json.encode(responseBody), 200);
      });

      final ProductsGateway gateway = ProductsGateway(client: client);
      expect(gateway.fetchSearchProducts(text: 'FooBar'),
          completion(responseBody));
    });
    test('when status code is not 200 then throws error', () {
      final Client client = MockClient((request) async {
        return Response(json.encode([]), 500);
      });

      final ProductsGateway gateway = ProductsGateway(client: client);
      expect(gateway.fetchSearchProducts(text: 'FooBar'), throwsException);
    });
  });
}
