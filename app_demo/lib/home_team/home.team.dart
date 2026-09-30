import 'package:app_demo/common/contributions/contribution.registry.dart';

import 'contribution.home.team.dart';

///Entry point of the home team: registers everything the team contributes.
void registerHomeTeam(ContributionRegistry registry) {
  registry.register(HomeBottomNavigationBarContribution());
}
