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
    test('when fetchProducts return error then emits empty products', () async {
      _givenProductsError();

      _interactor.loadProducts();

      await expectLater(_interactor.observeProducts(), emits([]));
    });
    test('when fetchProducts return products then emits', () async {
      _givenProducts(_products);

      _interactor.loadProducts();

      await expectLater(_interactor.observeProducts(), emits([]));
    });
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

void _givenProductsError() {
  when(_gateway.fetchProducts()).thenAnswer((_) => Future.error(Error()));
}

void _givenSearchProducts(Iterable<Map<String, dynamic>> products) {
  when(_gateway.fetchSearchProducts())
      .thenAnswer((_) => Future.value(products));
}

void _givenSearchProductsError() {
  when(_gateway.fetchSearchProducts()).thenAnswer((_) => Future.error(Error()));
}

Iterable<Map<String, dynamic>> _products = [
  {
    "price": {
      "current": "R\$ 206,60",
      "installment": "12x R\$ 17,22 sem juros"
    },
    "picture":
        "https://img.elo7.com.br/product/main/134E8A7/kiy-chocolate-baby-poster.jpg",
    "title": "Kiy Chocolate Baby (com moldura)",
    "id": "1",
    "_link": "https://www.elo7.com.br/kiy-chocolate-baby-com-moldura/dp/7B8591"
  },
  {
    "price": {
      "current": "R\$ 331,70",
      "installment": "12x R\$ 27,64 sem juros"
    },
    "picture":
        "https://img.elo7.com.br/product/main/12E09FB/girafa-amigurumi-crianca.jpg",
    "title": "Girafa Amigurumi",
    "id": "2",
    "_link": "https://www.elo7.com.br/girafa-amigurumi/dp/74FEEA"
  },
  {
    "price": {
      "current": "R\$ 30,99",
      "nonPromotional": "R\$ 32,40",
      "installment": "Até 12x sem juros"
    },
    "picture":
        "https://img.elo7.com.br/product/main/104F695/kit-para-casamento-casamento.jpg",
    "title": "Caixinha de madeira com sabonetes artesanais",
    "id": "3",
    "_link":
        "https://www.elo7.com.br/caixinha-de-madeira-com-sabonetes-artesanais/dp/5046C0"
  },
];

class _ProductsGateway extends Mock implements ProductsGatewayContract {}
