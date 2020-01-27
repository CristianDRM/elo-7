import 'package:elo_7/components/boundaries/product/products_output_boundary_contract.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ProductsResultInfoViewBloc {
  const ProductsResultInfoViewBloc({
    @required ProductsOutputBoundaryContract boundary,
  })  : assert(boundary != null),
        _boundary = boundary;
  final ProductsOutputBoundaryContract _boundary;

  Stream<int> get observeCountOfProducts => _boundary.observeProducts
      .flatMap((products) => Stream.value(products.length));
}
