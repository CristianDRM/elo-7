import 'package:elo_7/components/boundaries/product/products_interactor.dart';
import 'package:elo_7/components/gateways/products_gateway_contract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

ProductsInteractor _interactor;
ProductsGatewayContract _gateway;
void main() {
  setUp(() {
    _gateway = _ProductsGateway();
    _interactor = ProductsInteractor(gateway: _gateway);
  });
  group('#loadProducts', () {
    test('when fetchProducts return error then emits empty products', () {});
    test('when fetchProducts return products then emits', () {});
  });

  group('#filterByName', () {
    test('when fetchSearchProducts return error then emits empty products',
        () {});
    test('when fetchSearchProducts return products then emits', () {});
  });

  group('#filterByCategory', () {
    test('when sets a Category then filter products', () {});
  });
}

void _givenProducts(Iterable<Map<String, dynamic>> products) {
  when(_gateway.fetchProducts()).thenAnswer((_) => Future.value(products));
}

void _givenSearchProducts(Iterable<Map<String, dynamic>> products) {
  when(_gateway.fetchSearchProducts())
      .thenAnswer((_) => Future.value(products));
}

class _ProductsGateway extends Mock implements ProductsGatewayContract {}
