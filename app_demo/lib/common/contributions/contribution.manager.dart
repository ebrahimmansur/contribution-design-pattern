import 'package:app_demo/common/contributions/contribution.registry.dart';

import 'contribution.contracts.dart';

///The component that encapsulate the responsibility of providing the right contributions
///to the consumers.
class ContributionManager<T extends IContribution> {
  final ContributionRegistry _registry = ContributionRegistry();
  List<T> get contributions {
    final list = _registry.contributions.whereType<T>();

    return list.where((element) => element.isEnabled).toList();
  }
}
