import 'package:elo_7/components/boundaries/product/products_input_boundary_contract.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ProductsCategoryFilterViewBloc {
  ProductsCategoryFilterViewBloc(
      {@required ProductsFilterCategoryBoundaryContract boundary})
      : assert(boundary != null),
        _filters = const {
          CategoryProductFilter.all: 'Todos',
          CategoryProductFilter.installment: 'Parcelamento sem juros',
          CategoryProductFilter.promotion: 'Preços promocionais',
        },
        _boundary = boundary;
  final ProductsFilterCategoryBoundaryContract _boundary;
  final Map<CategoryProductFilter, String> _filters;
  final BehaviorSubject<String> _selectedSubject = BehaviorSubject();

  void onChangeCategory(String value) {
    CategoryProductFilter category = _filters.entries
        .firstWhere(
          (entry) => entry.value == value,
          orElse: () => MapEntry(CategoryProductFilter.all, ''),
        )
        .key;
    _boundary.filterByCategory(category);
    _selectedSubject.add(value);
  }

  Iterable<String> filters() => CategoryProductFilter.values.map(
        (item) => _filters[item],
      );
  Stream<String> get selectedItem =>
      _selectedSubject.startWith(_filters[CategoryProductFilter.all]);
}
