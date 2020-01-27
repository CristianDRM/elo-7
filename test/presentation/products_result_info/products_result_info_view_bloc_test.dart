import 'package:elo_7/components/boundaries/product/products_output.dart';
import 'package:elo_7/components/boundaries/product/products_output_boundary_contract.dart';
import 'package:elo_7/components/presentation/products_result_info/products_result_info_view_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

ProductsOutputBoundaryContract _boundary;
ProductsResultInfoViewBloc _bloc;
BehaviorSubject<Iterable<ProductOutput>> _countOfProductsSubject;

void main() {
  setUp(() {
    _boundary = _ProductsOutputBoundaryContract();
    _countOfProductsSubject = BehaviorSubject();
    when(_boundary.observeProducts())
        .thenAnswer((_) => _countOfProductsSubject);
    _bloc = ProductsResultInfoViewBloc(boundary: _boundary);
  });

  test('#observeCountOfProducts', () {
    _givenProducts(products: [
      for (int i = 0; i < 5; i++)
        ProductOutput(
          id: '',
          link: '',
          picture: '',
          price: ProductPrice(current: ''),
          title: '',
        ),
    ]);
    expect(_bloc.observeCountOfProducts, emits(5));
  });
}

void _givenProducts({Iterable<ProductOutput> products}) =>
    _countOfProductsSubject.add(products);

class _ProductsOutputBoundaryContract extends Mock
    implements ProductsOutputBoundaryContract {}
