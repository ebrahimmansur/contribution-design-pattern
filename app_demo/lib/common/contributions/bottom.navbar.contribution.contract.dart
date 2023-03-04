// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'contribution.contracts.dart';

abstract class IBottomNavigationBarContribution implements IContribution {
  BottomNavigationBarContributionData get state;
  Widget view(BuildContext context);
}

class BottomNavigationBarContributionData {
  final String label;
  final IconData icon;
  const BottomNavigationBarContributionData({
    required this.label,
    required this.icon,
  });
}
