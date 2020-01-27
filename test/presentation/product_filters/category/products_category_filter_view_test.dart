import 'dart:ui';

import 'package:elo_7/components/boundaries/product/products_input_boundary_contract.dart';
import 'package:elo_7/components/presentation/products_filter/category/products_category_filter_view.dart';
import 'package:elo_7/components/presentation/products_filter/category/products_category_filter_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../common/testable_widget.dart';

void main() async {
  await loadFonts();
  setupGoldenFile(size: Size(220, 400));
  testWidgets('when is expanded then take screenshot', (tester) async {
    await _pumpWidget(tester);
    await tester.pumpAndSettle();
    await _takeScreenshot('collapsed');
  });

  testWidgets('when is selected then take screenshot', (tester) async {
    await _pumpWidget(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Todos'));
    await tester.pumpAndSettle();
    await _takeScreenshot('expanded');
  });
}

Future<void> _takeScreenshot(String fileName) => matchGoldenFile(
      find.byType(TestableWidget),
      outputPath: '../../../screenshots/category/$fileName.png',
    );

Future<void> _pumpWidget(WidgetTester tester) => tester.pumpWidget(
      TestableWidget(
        child: Provider<ProductsCategoryFilterViewBloc>(
          create: (_) => ProductsCategoryFilterViewBloc(
            boundary: _ProductsFilterCategoryBoundaryContract(),
          ),
          child: Scaffold(
            body: ProductsCategoryFilterView(),
          ),
        ),
      ),
    );

class _ProductsFilterCategoryBoundaryContract extends Mock
    implements ProductsFilterCategoryBoundaryContract {}
