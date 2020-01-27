import 'dart:io';
import 'dart:typed_data';

import 'package:elo_7/design_tokens.dart';
import 'package:elo_7/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elo_7/design_tokens.dart' as token;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

class TestableWidget extends StatelessWidget {
  TestableWidget({@required this.child}) : assert(child != null);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return MaterialApp(
      supportedLocales: i18n.supportedLocales,
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      theme: token.theme,
      home: LayoutTheme(
        child: RepaintBoundary(
          child: Directionality(
            child: TickerMode(
              enabled: false,
              child: ClipRect(child: child),
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}

Future<void> loadFonts() {
  final fontData = File('assets/fonts/Roboto/Roboto-Regular.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final fontData2 = File('assets/fonts/Roboto/Roboto-Bold.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final fontData3 = File('assets/fonts/Roboto/Roboto-Light.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final fontData4 = File('assets/fonts/Roboto/Roboto-Medium.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final fontData5 = File('assets/fonts/Roboto/Roboto-Thin.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final fontLoader = FontLoader('Roboto')
    ..addFont(fontData)
    ..addFont(fontData2)
    ..addFont(fontData3)
    ..addFont(fontData4)
    ..addFont(fontData5);
  return fontLoader.load();
}

void setupGoldenFile({Size size}) {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();
  binding.window.physicalSizeTestValue = size;
  binding.window.devicePixelRatioTestValue = 1.0;
}

Future<void> matchGoldenFile(Finder find, {String outputPath}) =>
    expectLater(find, matchesGoldenFile(outputPath));
