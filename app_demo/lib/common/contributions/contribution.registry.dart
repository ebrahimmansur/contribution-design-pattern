import 'contribution.contracts.dart';

///The component that encapsulate the responsibility of registering contributions.
///
///It knows nothing about the teams: each team registers its own contributions
///from the composition root (`main.dart`), so `common` never imports a feature.
class ContributionRegistry {
  final List<IContribution> _contributions = [];

  void register(IContribution contribution) {
    _contributions.add(contribution);
  }

  void registerAll(Iterable<IContribution> contributions) {
    contributions.forEach(register);
  }

  List<IContribution> get contributions => List.unmodifiable(_contributions);
}
