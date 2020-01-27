import 'package:elo_7/components/boundaries/product/products_input_boundary_contract.dart';
import 'package:elo_7/components/boundaries/product/products_interactor.dart';
import 'package:elo_7/components/boundaries/product/products_output.dart';
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

      verify(_gateway.fetchProducts()).called(1);
      await expectLater(_interactor.observeProducts, emits([]));
    });
    test('when fetchProducts return products then emits', () async {
      _givenProducts(_products);

      _interactor.loadProducts();

      verify(_gateway.fetchProducts()).called(1);
      await expectLater(_interactor.observeProducts, emits(_productsMapped));
    });
  });

  group('#filterByName', () {
    test('when fetchSearchProducts return error then emits empty products',
        () async {
      _givenSearchProductsError();

      _interactor.filterByName('Foobar');

      verify(_gateway.fetchSearchProducts(text: 'Foobar')).called(1);
      await expectLater(_interactor.observeProducts, emits([]));
    });
    test('when fetchSearchProducts return products then emits', () async {
      _givenSearchProducts(_products);

      _interactor.filterByName('FooBar');

      verify(_gateway.fetchSearchProducts(text: 'FooBar')).called(1);
      await expectLater(_interactor.observeProducts, emits(_productsMapped));
    });
  });

  group('#filterByCategory', () {
    test('when filters by promotion then filter products', () async {
      _givenProducts(_products);

      _interactor.loadProducts();
      _interactor.filterByCategory(CategoryProductFilter.promotion);

      await expectLater(
        _interactor.observeProducts,
        emitsInOrder([
          _productsMapped,
          [_withPromotion],
        ]),
      );
    });

    test('when filters by installment then filter products', () async {
      _givenProducts(_products);

      _interactor.loadProducts();
      _interactor.filterByCategory(CategoryProductFilter.installment);

      await expectLater(
        _interactor.observeProducts,
        emitsInOrder([
          _productsMapped,
          [_withInstallment],
        ]),
      );
    });

    test('when filters by all then filter products', () async {
      _givenProducts(_products);

      _interactor.loadProducts();
      _interactor.filterByCategory(CategoryProductFilter.all);

      await expectLater(
          _interactor.observeProducts,
          emitsInOrder([
            _productsMapped,
            _productsMapped,
          ]));
    });
  });
}

void _givenProducts(Iterable<Map<String, dynamic>> products) {
  when(_gateway.fetchProducts()).thenAnswer((_) => Future.value(products));
}

void _givenProductsError() {
  when(_gateway.fetchProducts()).thenAnswer((_) => Future.error(Error()));
}

void _givenSearchProducts(Iterable<Map<String, dynamic>> products) {
  when(_gateway.fetchSearchProducts(text: anyNamed('text')))
      .thenAnswer((_) => Future.value(products));
}

void _givenSearchProductsError() {
  when(_gateway.fetchSearchProducts(text: anyNamed('text')))
      .thenAnswer((_) => Future.error(Error()));
}

final ProductOutput _onlyWithCurrent = ProductOutput(
  price: ProductPrice(
    current: "R\$ 206,60",
  ),
  picture:
      "https://img.elo7.com.br/product/main/134E8A7/kiy-chocolate-baby-poster.jpg",
  title: "Kiy Chocolate Baby (com moldura)",
  id: "1",
  link: "https://www.elo7.com.br/kiy-chocolate-baby-com-moldura/dp/7B8591",
);

final ProductOutput _withInstallment = ProductOutput(
  price: ProductPrice(
    current: "R\$ 331,70",
    installment: "12x R\$ 27,64 sem juros",
  ),
  picture:
      "https://img.elo7.com.br/product/main/12E09FB/girafa-amigurumi-crianca.jpg",
  title: "Girafa Amigurumi",
  id: "2",
  link: "https://www.elo7.com.br/girafa-amigurumi/dp/74FEEA",
);

final ProductOutput _withPromotion = ProductOutput(
  price: ProductPrice(
    current: "R\$ 30,99",
    promotional: "R\$ 32,40",
  ),
  picture:
      "https://img.elo7.com.br/product/main/104F695/kit-para-casamento-casamento.jpg",
  title: "Caixinha de madeira com sabonetes artesanais",
  id: "3",
  link:
      "https://www.elo7.com.br/caixinha-de-madeira-com-sabonetes-artesanais/dp/5046C0",
);

final Iterable<ProductOutput> _productsMapped = [
  _onlyWithCurrent,
  _withInstallment,
  _withPromotion,
];

Iterable<Map<String, dynamic>> _products = [
  {
    "price": {
      "current": "R\$ 206,60",
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
