import 'package:app_demo/common/contributions/bottom.navbar.contribution.contract.dart';
import 'package:flutter/material.dart';

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
