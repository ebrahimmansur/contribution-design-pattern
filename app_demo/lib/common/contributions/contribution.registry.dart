import 'contribution.contracts.dart';

///The component that encapsulate the responsibility of registering contributions.
///
///It knows nothing about the teams: each team registers its own contributions
///from the composition root (`main.dart`), so `common` never imports a feature.
class ContributionRegistry {
  final List<IContribution> _contributions = [];

  ///Throws a [StateError] when another contribution already uses the same id,
  ///so two teams can't silently collide.
  void register(IContribution contribution) {
    final id = contribution.contributionId;
    if (_contributions.any((c) => c.contributionId == id)) {
      throw StateError('A contribution with id "$id" is already registered.');
    }
    _contributions.add(contribution);
  }

  void registerAll(Iterable<IContribution> contributions) {
    contributions.forEach(register);
  }

  List<IContribution> get contributions => List.unmodifiable(_contributions);
}
