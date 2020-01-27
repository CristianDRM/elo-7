import 'package:elo_7/di/dependencies_provider_contract.dart';
import 'package:elo_7/pages/home_page.dart';
import 'package:elo_7/pages/products_search/products_search_page.dart';
import 'package:flutter/material.dart';

class RoutesHandler {
  RoutesHandler({
    @required this.dependeciesProvider,
  }) : assert(dependeciesProvider != null);
  final DependenciesProviderContract dependeciesProvider;

  Navigator navigator({GlobalKey<NavigatorState> navigatorKey}) => Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          if (settings.name == '/') {
            builder = (_) => dependeciesProvider.home(HomePage());
          } else if (settings.name == '/search') {
            builder = (_) => dependeciesProvider.search(ProductsSearchPage());
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      );
}
