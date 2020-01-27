import 'package:elo_7/components/boundaries/product/products_input_boundary_contract.dart';
import 'package:elo_7/components/boundaries/product/products_output_boundary_contract.dart';
import 'package:elo_7/components/gateways/products_gateway_contract.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

import 'products_output.dart';

class ProductsInteractor
    implements
        ProductsLoadBoundaryContract,
        ProductsOutputBoundaryContract,
        ProductsFilterNameBoundaryContract,
        ProductsFilterCategoryBoundaryContract {
  ProductsInteractor({
    @required ProductsGatewayContract gateway,
  })  : assert(gateway != null),
        _gateway = gateway;

  final ProductsGatewayContract _gateway;
  final BehaviorSubject<Iterable<ProductOutput>> _productsSubject =
      BehaviorSubject();
  final BehaviorSubject<CategoryProductFilter> _categorySubject =
      BehaviorSubject();

  @override
  Stream<Iterable<ProductOutput>> observeProducts() =>
      _productsSubject.flatMap(_filterProducts);

  void loadProducts() {
    _gateway
        .fetchProducts()
        .then((products) =>
            products.map((product) => ProductOutput.fromJson(product)))
        .catchError((_) => <ProductOutput>[])
        .then(_productsSubject.add);
  }

  @override
  void filterByName(String text) {
    _gateway
        .fetchSearchProducts(text: text)
        .then((products) =>
            products.map((product) => ProductOutput.fromJson(product)))
        .catchError((_) => <ProductOutput>[])
        .then(_productsSubject.add);
  }

  Stream<Iterable<ProductOutput>> _filterProducts(
          Iterable<ProductOutput> products) =>
      _categorySubject.startWith(CategoryProductFilter.all).map(
        (category) {
          switch (category) {
            case CategoryProductFilter.promotion:
              return products.where(
                (product) => product.price.promotional != null,
              );
            case CategoryProductFilter.installment:
              return products.where(
                (product) => product.price.installment != null,
              );
            case CategoryProductFilter.all:
              return products;
          }
          return products;
        },
      );

  @override
  void filterByCategory(CategoryProductFilter category) =>
      _categorySubject.add(category);

  void dispose() {
    _productsSubject.close();
  }
}
