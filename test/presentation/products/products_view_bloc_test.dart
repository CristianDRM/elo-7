import 'package:elo_7/components/boundaries/product/products_output.dart';
import 'package:elo_7/components/boundaries/product/products_output_boundary_contract.dart';
import 'package:elo_7/components/presentation/products/product/product_view_model.dart';
import 'package:elo_7/components/presentation/products/products_view_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

ProductsOutputBoundaryContract _boundary;
BehaviorSubject<Iterable<ProductOutput>> _observeProducts;
ProductsViewBloc _bloc;

void main() {
  setUp(() {
    _boundary = _ProductsOutputBoundaryContract();
    _observeProducts = BehaviorSubject();
    when(_boundary.observeProducts()).thenAnswer((_) => _observeProducts);
    _bloc = ProductsViewBloc(boundary: _boundary);
  });

  test('#observeProducts', () {
    _givenProducts(
      products: [
        for (int i = 0; i < 5; i++)
          ProductOutput(
            id: '$i',
            link: 'link$i',
            picture: 'picture $i',
            price: ProductPrice(current: '$i', promotional: 'test'),
            title: 'title $i',
          ),
      ],
    );
    expect(
      _bloc.observeProducts,
      emits(
        [
          for (int i = 0; i < 5; i++)
            ProductViewModel(
              detailUrl: 'link$i',
              picture: 'picture $i',
              title: 'title $i',
              hasDiscount: true,
              hasInstallment: false,
              installment: null,
              priceWithDiscount: 'test',
              price: '$i',
            ),
        ],
      ),
    );
  });
}

void _givenProducts({Iterable<ProductOutput> products}) =>
    _observeProducts.add(products);

class _ProductsOutputBoundaryContract extends Mock
    implements ProductsOutputBoundaryContract {}
