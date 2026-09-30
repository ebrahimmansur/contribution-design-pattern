# app_demo

Flutter demo of the **Contribution design pattern**: feature teams contribute tabs to a shared bottom navigation bar without the bar (or the shared code) knowing about them.

See the [root README](../README.md) for the design and the list of improvements.

## Getting Started

```bash
flutter pub get
flutter run
flutter test
```

## Project layout

```
lib/
├── main.dart                          # composition root: registers every team, hosts the bottom nav
├── common/contributions/              # shared contracts, knows nothing about the teams
│   ├── contribution.contracts.dart    # IContribution, IOrderedContribution
│   ├── bottom.navbar.contribution.contract.dart
│   ├── contribution.registry.dart     # register / registerAll, duplicate-id guard
│   └── contribution.manager.dart      # enabled + typed + ordered contributions
├── home_team/
│   ├── home.team.dart                 # registerHomeTeam()
│   └── contribution.home.team.dart
└── profile_team/
    ├── profile.team.dart              # registerProfileTeam()
    └── contribution.profile.team.dart
test/
├── contribution_manager_test.dart     # registry + manager rules
├── widget_test.dart                   # entry point behaviour
└── fakes/fake_contributions.dart
```
