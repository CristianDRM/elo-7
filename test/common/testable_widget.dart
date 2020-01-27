import 'package:elo_7/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TestableWidget extends StatelessWidget {
  TestableWidget({@required this.child}) : assert(child != null);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        supportedLocales: i18n.supportedLocales,
        localizationsDelegates: [
          i18n,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        home: child,
      ),
    );
  }
}
