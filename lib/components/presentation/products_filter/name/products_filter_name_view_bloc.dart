import 'package:elo_7/components/boundaries/product/products_input_boundary_contract.dart';
import 'package:meta/meta.dart';

class ProductsFilterNameViewBloc {
  const ProductsFilterNameViewBloc({
    @required ProductsFilterNameBoundaryContract boundary,
  })  : assert(boundary != null),
        _boundary = boundary;
  final ProductsFilterNameBoundaryContract _boundary;

  void onNameChange(String text) => _boundary.filterByName(text);
}
