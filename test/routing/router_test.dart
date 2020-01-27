import 'package:elo_7/routing/router_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

Router _router;
_NavigatorState _state;
GlobalKey<NavigatorState> _key;
void main() {
  setUp(() {
    _key = _GlobalKey();
    _state = _NavigatorState();
    when(_key.currentState).thenReturn(_state);
    _router = Router(navigatorKey: _key);
  });

  test('#openSearch', () {
    _state.pushNamedCallback = (routeName, arguments) {
      expect(routeName, equals('/search'));
    };
    _router.openSearch();
  });

  test('#openWebView', () {
    _state.pushCallback = (route) {
      expect(route, equals(anything));
    };
    _router.openWebView(url: 'FooBar', title: 'Foo');
  });
}

class _GlobalKey extends Mock implements GlobalKey<NavigatorState> {}

class _NavigatorState extends NavigatorState {
  void Function(String, Object) pushNamedCallback;

  @override
  Future<T> pushNamed<T extends Object>(String routeName, {Object arguments}) {
    pushNamedCallback(routeName, arguments);
    return super.pushNamed(routeName, arguments: arguments);
  }

  void Function(Route) pushCallback;
  @override
  Future<T> push<T extends Object>(Route<T> route) {
    pushCallback(route);
    return super.push(route);
  }
}
