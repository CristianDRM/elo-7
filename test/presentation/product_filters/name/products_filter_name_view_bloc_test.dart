import 'package:elo_7/components/boundaries/product/products_input_boundary_contract.dart';
import 'package:elo_7/components/presentation/products_filter/name/products_filter_name_view_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

ProductsFilterNameBoundaryContract _boundary;
ProductsFilterNameViewBloc _bloc;

void main() {
  setUp(() {
    _boundary = _ProductsFilterNameBoundaryContract();
    _bloc = ProductsFilterNameViewBloc(boundary: _boundary);
  });

  test('#onNameChange', () async {
    _bloc.onNameChange('FooBar');
    verify(_boundary.filterByName('FooBar')).called(1);
  });
}

class _ProductsFilterNameBoundaryContract extends Mock
    implements ProductsFilterNameBoundaryContract {}
