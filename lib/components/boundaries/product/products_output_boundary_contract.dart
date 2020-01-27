import 'products_output.dart';

abstract class ProductsOutputBoundaryContract {
  Stream<Iterable<ProductOutput>> observeProducts();
}
