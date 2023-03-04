import 'package:app_demo/common/contributions/bottom.navbar.contribution.contract.dart';
import 'package:app_demo/common/contributions/contribution.manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contribution Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Contribution Design Pattern'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ContributionManager<IBottomNavigationBarContribution>
      _contributionManager = ContributionManager();

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
