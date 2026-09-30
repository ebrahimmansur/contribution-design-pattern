import 'contribution.contracts.dart';
import 'contribution.registry.dart';

///The component that encapsulate the responsibility of providing the right contributions
///to the consumers.
class ContributionManager<T extends IContribution> {
  final ContributionRegistry _registry;

  ContributionManager(this._registry);

  ///Enabled contributions of type [T], sorted by [IOrderedContribution.order]
  ///and then by id so the result is always deterministic.
  List<T> get contributions {
    final list = _registry.contributions
        .whereType<T>()
        .where((element) => element.isEnabled)
        .toList();

    list.sort(_compare);
    return list;
  }

  static int _compare(IContribution a, IContribution b) {
    final byOrder = _orderOf(a).compareTo(_orderOf(b));
    return byOrder != 0
        ? byOrder
        : a.contributionId.compareTo(b.contributionId);
  }

  static int _orderOf(IContribution c) =>
      c is IOrderedContribution ? c.order : 0;
}
