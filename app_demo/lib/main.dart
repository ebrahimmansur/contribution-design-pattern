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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
        items: bottomContribution
            .map((e) => BottomNavigationBarItem(
                icon: Icon(e.state.icon), label: e.state.label))
            .toList(),
      ),
      body: Center(
        child: bottomContribution[_selectedIndex].view(context),
      ),
    );
  }
}
