abstract class ProductsGatewayContract {
  Future<Iterable<Map<String, dynamic>>> fetchSearchProducts({String text});
  Future<Iterable<Map<String, dynamic>>> fetchProducts();
}
