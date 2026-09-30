import 'package:app_demo/common/contributions/bottom.navbar.contribution.contract.dart';
import 'package:app_demo/common/contributions/contribution.contracts.dart';
import 'package:flutter/material.dart';

class FakeTabContribution implements IBottomNavigationBarContribution {
  FakeTabContribution(
    this.contributionId, {
    this.order = 0,
    this.isEnabled = true,
  });

  @override
  final String contributionId;

  @override
  final int order;

  @override
  final bool isEnabled;

  @override
  BottomNavigationBarContributionData get state =>
      BottomNavigationBarContributionData(
        label: contributionId,
        icon: Icons.circle,
      );

  @override
  Widget view(BuildContext context) => Text('$contributionId-view');
}

///A contribution for another entry point, used to check type filtering.
class FakeOtherContribution implements IContribution {
  FakeOtherContribution(this.contributionId);

  @override
  final String contributionId;

  @override
  bool get isEnabled => true;
}
