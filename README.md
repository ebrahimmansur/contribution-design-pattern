# contribution-design-pattern
A design solution to deal with decoupling features  from entry-points component like composable screens, app-bar, sidebar and bottom-navigation-bar.

### Entry-point
- bottom navigation bar


### Features owned by a team
- profile - team
- home - team


### Dependency direction

```
before:  common ──► home_team, profile_team        (shared layer knows every feature)

after:   home_team ──►  common  ◄── profile_team   (features depend on contracts only)
                          ▲
                        main.dart                   (composition root wires teams in)
```


### The Contribution components

#### IContribution
- The base component that encapsulate the Contribution information.

```dart
abstract class IContribution {
  String get contributionId;
  bool get isEnabled;
}
```

#### IOrderedContribution
- A contribution that wants a fixed position inside its entry point. Lower values come first.

```dart
abstract class IOrderedContribution implements IContribution {
  int get order;
}
```

#### IBottomNavigationBarContribution
- A component that extends IContribution and encapsulate specific contribution

```dart
abstract class IBottomNavigationBarContribution implements IOrderedContribution {
  BottomNavigationBarContributionData get state;
  Widget view(BuildContext context);
}
```

#### BottomNavigationBarContributionData 
- The Component that encapsulate the state of the contribution.

```dart
class BottomNavigationBarContributionData {
  final String label;
  final IconData icon;
  const BottomNavigationBarContributionData({
    required this.label,
    required this.icon,
  });
}
```

#### ContributionRegistry
- The component that encapsulate the responsibility of registering contributions.
- It does **not** import any team. Teams register themselves into it.

```dart
class ContributionRegistry {
  final List<IContribution> _contributions = [];

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
```

#### ContributionManager
- The component that encapsulate the responsibility of providing the right contributions to the consumers.
- Returns only enabled contributions of type `T`, sorted by `order` (then by id).

```dart
class ContributionManager<T extends IContribution> {
  final ContributionRegistry _registry;

  ContributionManager(this._registry);

  List<T> get contributions {
    final list = _registry.contributions
        .whereType<T>()
        .where((element) => element.isEnabled)
        .toList();

    list.sort(_compare);
    return list;
  }
  // _compare: by order, then by contributionId
}
```

#### Composition root (`main.dart`)
- The only place that knows about every team.

```dart
void main() {
  runApp(MyApp(registry: createRegistry()));
}

ContributionRegistry createRegistry() {
  final registry = ContributionRegistry();
  registerProfileTeam(registry);
  registerHomeTeam(registry);
  return registry;
}
```

---

#### Profile Team Contribution

```dart
void registerProfileTeam(ContributionRegistry registry) {
  registry.register(ProfileBottomNavigationBarContribution());
}

class ProfileBottomNavigationBarContribution
    implements IBottomNavigationBarContribution {
  @override
  String get contributionId => 'profile.bottom-nav';

  @override
  bool get isEnabled => true;

  @override
  int get order => 100;

  @override
  Widget view(BuildContext context) {
    return const Text("Profile-Screen");
  }

  @override
  BottomNavigationBarContributionData get state =>
      const BottomNavigationBarContributionData(
        label: "Profile",
        icon: Icons.person,
      );
}
```



#### Home Team Contribution
```dart
void registerHomeTeam(ContributionRegistry registry) {
  registry.register(HomeBottomNavigationBarContribution());
}

class HomeBottomNavigationBarContribution
    implements IBottomNavigationBarContribution {
  @override
  String get contributionId => 'home.bottom-nav';

  @override
  bool get isEnabled => true;

  @override
  int get order => 0;

  @override
  Widget view(BuildContext context) {
    return const Text("Home");
  }

  @override
  BottomNavigationBarContributionData get state =>
      const BottomNavigationBarContributionData(
        icon: Icons.home,
        label: "Home",
      );
}
```

---

### How to add a new team contribution
1. Create a folder for the team (e.g. `lib/settings_team/`) and implement `IBottomNavigationBarContribution` with a unique `contributionId` and an `order`.
2. Add a `registerSettingsTeam(ContributionRegistry registry)` function in the team folder.
3. Call it from `createRegistry()` in `main.dart`. Nothing in `common/` changes.

---

### Improvements

| # | What changed | Why |
|---|---|---|
| 1 | **Registry no longer imports the teams.** It is now a store with `register` / `registerAll`. Each team exposes its own `register…Team` function and `main.dart` wires them together. | The first version had `common` → `home_team`, `profile_team`, which is the exact coupling the pattern is meant to remove. Now features depend on the contracts, not the other way around, and adding a team never touches the shared layer. |
| 2 | **Registry is injected into `ContributionManager`.** | Before, every manager created its own registry, which built fresh contribution objects each time. Injection gives one source of truth and makes the manager testable with fake contributions. |
| 3 | **Duplicate `contributionId` throws a `StateError`.** IDs are normalized to `<team>.<entry-point>`. | With many teams, two of them registering the same id is an easy mistake. Failing fast at startup beats a silent collision. |
| 4 | **Ordering via `IOrderedContribution`.** | Tab order used to depend on the order of the list in the registry. Each team now owns its position, so registration order does not matter. |
| 5 | **Resilient entry point.** The index is clamped, the nav bar is hidden with fewer than 2 items, there is an empty state, and the body uses `IndexedStack`. | A team can disable its contribution (`isEnabled`), so the entry point must survive a changing list. `BottomNavigationBar` asserts with fewer than 2 items. `IndexedStack` keeps each team's screen state when switching tabs. |
| 6 | **Tests.** Unit tests for the registry and manager, and widget tests for the entry point. The old counter template test is gone. | The default test never matched the app and always failed. The new tests pin down the pattern's rules: filtering, type matching, ordering, and duplicate IDs. |
| 7 | **Upgraded to Dart 3** and `flutter_lints` 6. | The project was pinned to `<3.0.0`. It now builds with current Flutter and lints cleanly. |

### Run it
```bash
cd app_demo
flutter pub get
flutter test
flutter run
```
