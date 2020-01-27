import 'package:elo_7/components/boundaries/availability/availability_output_boundary_contract.dart';
import 'package:elo_7/pages/products_search/products_search_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

AvailabilityOutputBoundaryContract _boundary;
ProductsSearchPageBloc _bloc;
BehaviorSubject<bool> _availabilitySubject;
void main() {
  setUp(() {
    _boundary = _AvailabilityOutputBoundaryContract();
    _availabilitySubject = BehaviorSubject();
    when(_boundary.observeInternetAvailability).thenAnswer(
      (_) => _availabilitySubject,
    );
    _bloc = ProductsSearchPageBloc(availabilityBoundary: _boundary);
  });

  test('#observeInternetAvailability', () {
    _givenAvailability(isConnected: true);
    expect(_bloc.observeInternetAvailability, emits(true));

    _givenAvailability(isConnected: false);
    expect(_bloc.observeInternetAvailability, emits(false));
  });
}

void _givenAvailability({bool isConnected}) =>
    _availabilitySubject.add(isConnected);

class _AvailabilityOutputBoundaryContract extends Mock
    implements AvailabilityOutputBoundaryContract {}
