import 'dart:ui';

import 'package:elo_7/components/presentation/products/product/product_view.dart';
import 'package:elo_7/components/presentation/products/product/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/testable_widget.dart';

void main() async {
  await loadFonts();
  setupGoldenFile(size: Size(220, 200));
  testWidgets('when has discount then take screenshot', (tester) async {
    await _pumpWidget(
      tester,
      ProductViewModel(
        detailUrl: '',
        hasInstallment: false,
        picture: '',
        hasDiscount: false,
        price: 'R\$22,00',
        title: 'Foobar product',
      ),
    );
    await tester.pumpAndSettle();
    await _takeScreenshot('min-properties');
  });

  testWidgets('when have all properties then take screenshot', (tester) async {
    await _pumpWidget(
      tester,
      ProductViewModel(
        detailUrl: '',
        hasInstallment: true,
        picture: '',
        hasDiscount: true,
        price: 'R\$22,00',
        priceWithDiscount: 'R\$20,00',
        title: 'Foobar product',
        installment: '12x Sem juros',
      ),
    );
    await tester.pumpAndSettle();
    await _takeScreenshot('max-properties');
  });
}

Future<void> _takeScreenshot(String fileName) => matchGoldenFile(
      find.byType(TestableWidget),
      outputPath: '../../screenshots/product/$fileName.png',
    );

Future<void> _pumpWidget(WidgetTester tester, ProductViewModel viewModel) =>
    tester.pumpWidget(
      TestableWidget(
        child: ProductView(
          product: viewModel,
        ),
      ),
    );
