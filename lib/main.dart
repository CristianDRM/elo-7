import 'package:elo_7/di/dependencies_provider.dart';
import 'package:elo_7/routing/routes_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:elo_7/generated/i18n.dart';
import 'package:splashscreen/splashscreen.dart';
import 'design_tokens.dart';

import 'di/dependencies_provider_contract.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
    final DependenciesProviderContract dependenciesProvider =
        DependenciesProvider(navigationKey: navigatorKey);
    final RoutesHandler route =
        RoutesHandler(dependeciesProvider: dependenciesProvider);

    final i18n = I18n.delegate;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      initialRoute: '/',
      theme: theme,
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: i18n.supportedLocales,
      home: SplashScreen(
        loaderColor: Colors.transparent,
        backgroundColor: theme.primaryColor,
        image: Image.asset('assets/launcher/icon.png'),
        photoSize: 60,
        seconds: 1,
        navigateAfterSeconds: LayoutTheme(
          child: route.navigator(
            navigatorKey: navigatorKey,
          ),
        ),
      ),
    );
  }
}
