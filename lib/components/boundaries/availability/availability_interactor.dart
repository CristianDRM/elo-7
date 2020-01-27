import 'package:connectivity/connectivity.dart';
import 'package:elo_7/components/boundaries/availability/availability_output_boundary_contract.dart';

class AvailabilityInteractor implements AvailabilityOutputBoundaryContract {
  final Connectivity _connectivity = Connectivity();

  @override
  Stream<bool> get observeInternetAvailability =>
      _connectivity.onConnectivityChanged
          .map((result) => result != ConnectivityResult.none)
          .asBroadcastStream();
}
