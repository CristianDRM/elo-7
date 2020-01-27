import 'package:elo_7/components/boundaries/availability/availability_output_boundary_contract.dart';
import 'package:meta/meta.dart';

class ProductsSearchPageBloc {
  const ProductsSearchPageBloc({
    @required AvailabilityOutputBoundaryContract availabilityBoundary,
  })  : assert(availabilityBoundary != null),
        _availabilityBoundary = availabilityBoundary;
  final AvailabilityOutputBoundaryContract _availabilityBoundary;

  Stream<bool> get observeInternetAvailability =>
      _availabilityBoundary.observeInternetAvailability;
}
