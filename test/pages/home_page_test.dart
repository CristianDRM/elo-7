import 'package:elo_7/pages/home_page.dart';
import 'package:elo_7/routing/router_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../common/testable_widget.dart';

RouterContract _router;
void main() {
  setUp(() {
    _router = _RouterContract();
  });

  testWidgets('finds Home title', (tester) async {
    await _pumpWidget(tester);
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('when taps on trailing action then calls openSearch',
      (tester) async {
    await _pumpWidget(tester);
    await tester.pumpAndSettle();

    await _pumpWidget(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.search));
    verify(_router.openSearch()).called(1);
  });
}

Future<void> _pumpWidget(WidgetTester tester) => tester.pumpWidget(
      Provider<RouterContract>(
        create: (_) => _router,
        child: TestableWidget(
          child: HomePage(),
        ),
      ),
    );

class _RouterContract extends Mock implements RouterContract {}
