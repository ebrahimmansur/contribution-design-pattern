import 'package:app_demo/common/contributions/contribution.registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_demo/main.dart';

import 'fakes/fake_contributions.dart';

void main() {
  testWidgets('bottom navigation bar shows team contributions',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(registry: createRegistry()));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Profile-Screen'), findsNothing);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    expect(find.text('Profile-Screen'), findsOneWidget);
  });

  testWidgets('disabled contributions are not shown',
      (WidgetTester tester) async {
    final registry = ContributionRegistry()
      ..registerAll([
        FakeTabContribution('a', order: 0),
        FakeTabContribution('b', order: 1, isEnabled: false),
        FakeTabContribution('c', order: 2),
      ]);

    await tester.pumpWidget(MyApp(registry: registry));

    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsNothing);
    expect(find.text('c'), findsOneWidget);
  });

  testWidgets('a single contribution renders without a nav bar',
      (WidgetTester tester) async {
    final registry = ContributionRegistry()
      ..register(FakeTabContribution('only'));

    await tester.pumpWidget(MyApp(registry: registry));

    expect(find.byType(BottomNavigationBar), findsNothing);
    expect(find.text('only-view'), findsOneWidget);
  });

  testWidgets('no contributions shows an empty state',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(registry: ContributionRegistry()));

    expect(find.text('No contributions available'), findsOneWidget);
  });
}
