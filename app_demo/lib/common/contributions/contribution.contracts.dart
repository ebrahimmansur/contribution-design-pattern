///The base component that encapsulate the Contribution information.
abstract class IContribution {
  String get contributionId;
  bool get isEnabled;
}

///A contribution that wants a fixed position inside its entry point.
///Lower values come first, so the order no longer depends on registration order.
abstract class IOrderedContribution implements IContribution {
  int get order;
}
