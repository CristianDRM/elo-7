import 'package:connectivity/connectivity.dart';
import 'package:elo_7/components/boundaries/availability/availability_output_boundary_contract.dart';
import 'package:meta/meta.dart';

class AvailabilityInteractor implements AvailabilityOutputBoundaryContract {
  AvailabilityInteractor({@required this.onConnectivityChanged});
  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  Stream<bool> get observeInternetAvailability => onConnectivityChanged
      .map((result) => result != ConnectivityResult.none)
      .asBroadcastStream();
}
