import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class RouterContract {
  const RouterContract();
  Future<void> openSearch();
  Future<void> openWebView({String url, String title});
}

class Router extends RouterContract {
  const Router({
    @required GlobalKey<NavigatorState> navigatorKey,
  })  : assert(navigatorKey != null),
        _navigatorKey = navigatorKey;
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Future<void> openSearch() => _navigatorKey.currentState.pushNamed('/search');
  @override
  Future<void> openWebView({String url, String title}) =>
      _navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text(title)),
            body: WebView(
              initialUrl: url,
            ),
          ),
        ),
      );
}
