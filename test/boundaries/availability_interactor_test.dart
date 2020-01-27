import 'package:connectivity/connectivity.dart';
import 'package:elo_7/components/boundaries/availability/availability_interactor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

AvailabilityInteractor _interactor;
BehaviorSubject<ConnectivityResult> _onConnectivityChangedSubject;

void main() {
  setUp(() {
    _onConnectivityChangedSubject = BehaviorSubject();
    _interactor = AvailabilityInteractor(
      onConnectivityChanged: _onConnectivityChangedSubject,
    );
  });

  test('#observeInternetAvailability', () {
    _onConnectivityChangedSubject.add(ConnectivityResult.mobile);
    expect(_interactor.observeInternetAvailability, emits(true));

    _onConnectivityChangedSubject.add(ConnectivityResult.wifi);
    expect(_interactor.observeInternetAvailability, emits(true));

    _onConnectivityChangedSubject.add(ConnectivityResult.none);
    expect(_interactor.observeInternetAvailability, emits(false));
  });
}
