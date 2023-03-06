# contribution-design-pattern
A design solution to deal with decoupling features  from entry-points component like app-bar, sidebar and bottom-navigation-bar.

### Entry-point
- bottom navigation bar


### Features owned by a team
- profile - team
- home - team


### The Contribution components

#### IContribution
- The base component that encapsulate the Contribution information.

```dart
abstract class IContribution {
  String get contributionId;
  bool get isEnabled;
}
```

#### IBottomNavigationBarContribution
- A component that extends IContribution and encapsulate specific contribution

```dart
abstract class IBottomNavigationBarContribution implements IContribution {
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

```dart
class ContributionRegistry {
  List<IContribution> get contributions => [
        //add contributions [we can use DI to avoid cycle-dependency reference]
        ProfileBottomNavigationBarContribution(),
        HomeBottomNavigationBarContribution()
      ];
}
```

#### ContributionManager
- The component that encapsulate the responsibility of providing the right contributions to the consumers.

```dart
class ContributionManager<T extends IContribution> {
  final ContributionRegistry _registry = ContributionRegistry();
  List<T> get contributions {
    final list = _registry.contributions.whereType<T>();

    return list.where((element) => element.isEnabled).toList();
  }
}
```

---

#### Profile Team Contribution

```dart
class ProfileBottomNavigationBarContribution
    implements IBottomNavigationBarContribution {
  @override
  String get contributionId => 'profile-bottom-navigationBar-contribution';

  @override
  bool get isEnabled => true;

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
class HomeBottomNavigationBarContribution
    implements IBottomNavigationBarContribution {
  @override
  String get contributionId => 'Home-BottomNavigationBar-Contribution';

  @override
  bool get isEnabled => true;

  @override
  Widget view(BuildContext context) {
    return const Text("Home");
  }

  @override
  BottomNavigationBarContributionData get state =>
      const BottomNavigationBarContributionData(
        icon: Icons.home,
        label: "Home-Screen",
      );
}
```



