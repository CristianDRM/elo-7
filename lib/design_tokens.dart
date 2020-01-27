import 'package:flutter/material.dart';

ThemeData theme = () {
  final defaultTheme = ThemeData();
  return ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Color(0XFFFD0061),
    textTheme: defaultTheme.textTheme.copyWith(
      body2: defaultTheme.textTheme.body2.copyWith(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade700,
      ),
      subhead: defaultTheme.textTheme.subtitle.copyWith(
        color: Color(0xFF7A7A7A),
      ),
      button: defaultTheme.textTheme.button.copyWith(
        color: Colors.grey.shade700,
      ),
    ),
  );
}();

class LayoutTheme extends InheritedWidget {
  const LayoutTheme({@required Widget child}) : super(child: child);
  final EdgesScheme edges = const EdgesScheme();
  final ButtonScheme button = const ButtonScheme();
  final ProductScheme product = const ProductScheme();
  final Elo7ColorScheme colors = const Elo7ColorScheme();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static LayoutTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LayoutTheme>();
}

class EdgesScheme {
  const EdgesScheme();
  final double small = 8;
  final double regular = 16;
  final double large = 24;
  final double xLarge = 32;
}

class ButtonScheme {
  const ButtonScheme();
  final double height = 54;
}

class ProductScheme {
  const ProductScheme();
  final double imageHeight = 120;
}

class Elo7ColorScheme {
  const Elo7ColorScheme();
  final Color shimmerBackground = Colors.white;
  final Color shimmerHighlight = const Color(0xFFDFDFDF);
  final Color shimmerBase = const Color(0xFFF5F5F5);
  final Color price = const Color(0XFFFA7326);
}
