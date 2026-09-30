import 'package:app_demo/common/contributions/bottom.navbar.contribution.contract.dart';
import 'package:app_demo/common/contributions/contribution.manager.dart';
import 'package:app_demo/common/contributions/contribution.registry.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes/fake_contributions.dart';

void main() {
  late ContributionRegistry registry;
  late ContributionManager<IBottomNavigationBarContribution> manager;

  setUp(() {
    registry = ContributionRegistry();
    manager = ContributionManager(registry);
  });

  List<String> ids() =>
      manager.contributions.map((e) => e.contributionId).toList();

  group('ContributionRegistry', () {
    test('throws when the same id is registered twice', () {
      registry.register(FakeTabContribution('a'));

      expect(
          () => registry.register(FakeTabContribution('a')), throwsStateError);
    });

    test('exposes an unmodifiable list', () {
      registry.register(FakeTabContribution('a'));

      expect(() => registry.contributions.add(FakeTabContribution('b')),
          throwsUnsupportedError);
    });
  });

  group('ContributionManager', () {
    test('filters out disabled contributions', () {
      registry.registerAll([
        FakeTabContribution('a'),
        FakeTabContribution('b', isEnabled: false),
      ]);

      expect(ids(), ['a']);
    });

    test('only returns contributions of the requested type', () {
      registry.registerAll([
        FakeTabContribution('tab'),
        FakeOtherContribution('sidebar'),
      ]);

      expect(ids(), ['tab']);
    });

    test('sorts by order regardless of registration order', () {
      registry.registerAll([
        FakeTabContribution('last', order: 100),
        FakeTabContribution('first', order: 0),
        FakeTabContribution('middle', order: 50),
      ]);

      expect(ids(), ['first', 'middle', 'last']);
    });

    test('breaks order ties by id', () {
      registry.registerAll([
        FakeTabContribution('b'),
        FakeTabContribution('a'),
      ]);

      expect(ids(), ['a', 'b']);
    });
  });
}
