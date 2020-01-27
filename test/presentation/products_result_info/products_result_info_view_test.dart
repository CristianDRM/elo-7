import 'dart:ui';

import 'package:elo_7/components/boundaries/product/products_output.dart';
import 'package:elo_7/components/boundaries/product/products_output_boundary_contract.dart';
import 'package:elo_7/components/presentation/products_result_info/products_result_info_view.dart';
import 'package:elo_7/components/presentation/products_result_info/products_result_info_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../common/testable_widget.dart';

final BehaviorSubject<Iterable<ProductOutput>> _productsSubject =
    BehaviorSubject.seeded(
  [
    for (int i = 0; i < 5; i++)
      ProductOutput(
        id: '',
        link: '',
        picture: '',
        price: ProductPrice(current: ''),
        title: '',
      )
  ],
);

void main() async {
  await loadFonts();
  setupGoldenFile(size: Size(300, 60));
  testWidgets('when loads then take screenshot', (tester) async {
    await _pumpWidget(tester);
    await tester.pump();
    await _takeScreenshot('normal');
  });
}

Future<void> _takeScreenshot(String fileName) => matchGoldenFile(
      find.byType(TestableWidget),
      outputPath: '../../screenshots/result_info/$fileName.png',
    );

Future<void> _pumpWidget(WidgetTester tester) {
  final ProductsOutputBoundaryContract boundary =
      _ProductsOutputBoundaryContract();

  when(boundary.observeProducts).thenAnswer((_) => _productsSubject);
  return tester.pumpWidget(
    TestableWidget(
      child: Provider<ProductsResultInfoViewBloc>(
        create: (_) => ProductsResultInfoViewBloc(
          boundary: boundary,
        ),
        child: ProductsResultInfoView(),
      ),
    ),
  );
}

class _ProductsOutputBoundaryContract extends Mock
    implements ProductsOutputBoundaryContract {}
