import 'package:app_demo/common/contributions/contribution.registry.dart';

import 'contribution.profile.team.dart';

///Entry point of the profile team: registers everything the team contributes.
void registerProfileTeam(ContributionRegistry registry) {
  registry.register(ProfileBottomNavigationBarContribution());
}
