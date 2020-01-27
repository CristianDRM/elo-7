import 'package:elo_7/components/boundaries/product/products_input_boundary_contract.dart';
import 'package:elo_7/components/presentation/products_filter/category/products_category_filter_view_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

ProductsFilterCategoryBoundaryContract _boundary;
ProductsCategoryFilterViewBloc _bloc;

void main() {
  setUp(() {
    _boundary = _ProductsFilterCategoryBoundaryContract();
    _bloc = ProductsCategoryFilterViewBloc(boundary: _boundary);
  });

  test('#onChangeCategory', () async {
    expect(
      _bloc.selectedItem,
      emitsInOrder([
        'Todos',
        'Preços promocionais',
        'Parcelamento sem juros',
        'Todos',
      ]),
    );
    _bloc
      ..onChangeCategory('Preços promocionais')
      ..onChangeCategory('Parcelamento sem juros')
      ..onChangeCategory('Todos');

    verify(_boundary.filterByCategory(CategoryProductFilter.all)).called(2);
    verify(_boundary.filterByCategory(CategoryProductFilter.installment))
        .called(1);
    verify(_boundary.filterByCategory(CategoryProductFilter.promotion))
        .called(1);
  });

  test('#filters', () {
    expect(_bloc.filters(), contains('Todos'));
    expect(_bloc.filters(), contains('Preços promocionais'));
    expect(_bloc.filters(), contains('Parcelamento sem juros'));
  });
}

class _ProductsFilterCategoryBoundaryContract extends Mock
    implements ProductsFilterCategoryBoundaryContract {}
