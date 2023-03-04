import 'package:app_demo/common/contributions/bottom.navbar.contribution.contract.dart';
import 'package:flutter/material.dart';

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
        label: "Home",
      );
}
