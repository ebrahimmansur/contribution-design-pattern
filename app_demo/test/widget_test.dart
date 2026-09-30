import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_demo/main.dart';

void main() {
  testWidgets('bottom navigation bar shows team contributions',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(registry: createRegistry()));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Profile'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    expect(find.text('Profile-Screen'), findsOneWidget);
  });
}
