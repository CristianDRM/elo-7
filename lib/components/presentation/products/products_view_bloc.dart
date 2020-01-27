import 'package:elo_7/components/boundaries/product/products_output_boundary_contract.dart';
import 'package:elo_7/components/presentation/products/product/product_view_model.dart';
import 'package:meta/meta.dart';

class ProductsViewBloc {
  const ProductsViewBloc({
    @required ProductsOutputBoundaryContract boundary,
  })  : assert(boundary != null),
        _boundary = boundary;
  final ProductsOutputBoundaryContract _boundary;

  Stream<Iterable<ProductViewModel>> get observeProducts =>
      _boundary.observeProducts().map(
            (products) => products.map(
              (product) => ProductViewModel(
                picture: product.picture,
                priceWithDiscount: product.price.promotional,
                installment: product.price.installment,
                hasDiscount: product.price.promotional != null,
                hasInstallment: product.price.installment != null,
                price: product.price.current,
                title: product.title,
                detailUrl: product.link,
              ),
            ),
          );
}
