import 'package:connectivity/connectivity.dart';
import 'package:elo_7/components/boundaries/availability/availability_interactor.dart';
import 'package:elo_7/components/boundaries/availability/availability_output_boundary_contract.dart';
import 'package:elo_7/components/boundaries/product/products_interactor.dart';
import 'package:elo_7/components/gateways/products_gateway.dart';
import 'package:elo_7/components/gateways/products_gateway_contract.dart';
import 'package:elo_7/components/presentation/products/products_view_bloc.dart';
import 'package:elo_7/components/presentation/products_filter/name/products_filter_name_view_bloc.dart';
import 'package:elo_7/components/presentation/products_filter/category/products_category_filter_view_bloc.dart';
import 'package:elo_7/components/presentation/products_result_info/products_result_info_view_bloc.dart';
import 'package:elo_7/pages/products_search/products_search_page_bloc.dart';
import 'package:elo_7/routing/router_contract.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dependencies_provider_contract.dart';

class DependenciesProvider extends DependenciesProviderContract {
  DependenciesProvider({@required this.navigationKey})
      : assert(navigationKey != null),
        router = Router(navigatorKey: navigationKey);

  final GlobalKey<NavigatorState> navigationKey;
  final RouterContract router;

  final ProductsGatewayContract _gateway = ProductsGateway(client: Client());

  @override
  Widget search(Widget child) {
    final Connectivity _connectivity = Connectivity();
    final AvailabilityInteractor availabilityInteractor =
        AvailabilityInteractor(
      onConnectivityChanged: _connectivity.onConnectivityChanged,
    );
    final ProductsInteractor interactor = ProductsInteractor(gateway: _gateway);

    availabilityInteractor.observeInternetAvailability
        .where((isConnected) => isConnected)
        .listen((_) => interactor.loadProducts());

    return MultiProvider(
      providers: [
        Provider<RouterContract>(create: (_) => router),
        Provider<ProductsSearchPageBloc>(
          create: (_) => ProductsSearchPageBloc(
            availabilityBoundary: availabilityInteractor,
          ),
          dispose: (_, __) {
            interactor.dispose();
          },
        ),
        Provider<AvailabilityOutputBoundaryContract>(
          create: (_) => availabilityInteractor,
        ),
        Provider<ProductsViewBloc>(
          create: (_) => ProductsViewBloc(boundary: interactor),
        ),
        Provider<ProductsCategoryFilterViewBloc>(
          create: (_) => ProductsCategoryFilterViewBloc(boundary: interactor),
        ),
        Provider<ProductsFilterNameViewBloc>(
          create: (_) => ProductsFilterNameViewBloc(boundary: interactor),
        ),
        Provider<ProductsResultInfoViewBloc>(
          create: (_) => ProductsResultInfoViewBloc(boundary: interactor),
        ),
      ],
      child: child,
    );
  }

  @override
  Widget home(Widget child) => MultiProvider(
        providers: [
          Provider<RouterContract>(create: (_) => router),
        ],
        child: child,
      );
}
