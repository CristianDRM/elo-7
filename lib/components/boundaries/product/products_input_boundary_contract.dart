abstract class ProductsLoadBoundaryContract {
  void loadProducts();
}

abstract class ProductsFilterNameBoundaryContract {
  void filterByName(String text);
}

abstract class ProductsFilterCategoryBoundaryContract {
  void filterByCategory(CategoryProductFilter category);
}

enum CategoryProductFilter { promotion, installment, all }
