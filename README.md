# contribution-design-pattern
A design solution to deal with decoupling features  from entry-points component like app-bar, sidebar and bottom-navigation-bar .

### Entry-point
- bottom navigation bar


### Features
- profile
- home


### The Contribution components

#### IContribution
- The base component that encapsulate the Contribution information.

```dart
abstract class IContribution {
  String get contributionId;
  bool get isEnabled;
}
```
