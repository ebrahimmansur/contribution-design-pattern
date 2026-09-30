import 'package:app_demo/common/contributions/bottom.navbar.contribution.contract.dart';
import 'package:app_demo/common/contributions/contribution.manager.dart';
import 'package:app_demo/common/contributions/contribution.registry.dart';
import 'package:app_demo/home_team/home.team.dart';
import 'package:app_demo/profile_team/profile.team.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(registry: createRegistry()));
}

///Composition root: the only place that knows about every team.
ContributionRegistry createRegistry() {
  final registry = ContributionRegistry();
  registerProfileTeam(registry);
  registerHomeTeam(registry);
  return registry;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.registry});

  final ContributionRegistry registry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contribution Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Contribution Design Pattern',
        registry: registry,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.registry});

  final String title;
  final ContributionRegistry registry;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ContributionManager<IBottomNavigationBarContribution>
      _contributionManager = ContributionManager(widget.registry);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomContribution = _contributionManager.contributions;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(bottomContribution),
      body: _buildBody(bottomContribution),
    );
  }

  ///BottomNavigationBar needs at least two items, so with fewer
  ///contributions the entry point simply hides it.
  Widget? _buildBottomNavigationBar(
      List<IBottomNavigationBarContribution> contributions) {
    if (contributions.length < 2) return null;

    return BottomNavigationBar(
      currentIndex: _safeIndex(contributions),
      type: BottomNavigationBarType.fixed,
      onTap: (value) => setState(() {
        _selectedIndex = value;
      }),
      items: contributions
          .map((e) => BottomNavigationBarItem(
              icon: Icon(e.state.icon), label: e.state.label))
          .toList(),
    );
  }

  ///IndexedStack keeps every team's view alive, so switching tabs
  ///does not throw away their state.
  Widget _buildBody(List<IBottomNavigationBarContribution> contributions) {
    if (contributions.isEmpty) {
      return const Center(child: Text('No contributions available'));
    }

    return IndexedStack(
      index: _safeIndex(contributions),
      children: contributions
          .map((e) => Center(
                key: ValueKey(e.contributionId),
                child: e.view(context),
              ))
          .toList(),
    );
  }

  ///A contribution can be disabled at runtime, so the stored index may be
  ///out of range for the current list.
  int _safeIndex(List<IBottomNavigationBarContribution> contributions) =>
      _selectedIndex.clamp(0, contributions.length - 1);
}
