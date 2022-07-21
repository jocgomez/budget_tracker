import 'package:budget_tracker/pages/home_page.dart';
import 'package:budget_tracker/pages/profile_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_filled)),
    const BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
  ];

  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _currentPageIndex,
        onTap: (index) => setState(() {
          _currentPageIndex = index;
        }),
      ),
    );
  }
}
