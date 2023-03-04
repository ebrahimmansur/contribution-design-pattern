import '../../home_team/contribution.home.team.dart';
import '../../profile_team/contribution.profile.team.dart';
import 'contribution.contracts.dart';

///The component that encapsulate the responsibility of registering contributions.
class ContributionRegistry {
  List<IContribution> get contributions => [
        //add contributions [we can use DI to avoid cycle-dependency reference]
        ProfileBottomNavigationBarContribution(),
        HomeBottomNavigationBarContribution()
      ];
}
