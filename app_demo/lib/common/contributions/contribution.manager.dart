import 'contribution.contracts.dart';
import 'contribution.registry.dart';

///The component that encapsulate the responsibility of providing the right contributions
///to the consumers.
class ContributionManager<T extends IContribution> {
  final ContributionRegistry _registry;

  ContributionManager(this._registry);

  List<T> get contributions {
    final list = _registry.contributions.whereType<T>();

    return list.where((element) => element.isEnabled).toList();
  }
}
