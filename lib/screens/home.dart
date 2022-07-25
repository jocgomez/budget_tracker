import 'package:budget_tracker/extension/set_budget_dialog.dart';
import 'package:budget_tracker/pages/home_page.dart';
import 'package:budget_tracker/pages/profile_page.dart';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:budget_tracker/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final themeService = context.watch<ThemeService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
        leading: IconButton(
          onPressed: () => themeService.darkTheme = !themeService.darkTheme,
          icon: Icon(
            themeService.darkTheme
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.attach_money),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SetBudgetDialog(
                  budgetToAdd: (budget) {
                    final budgetService = context.read<BudgetService>();
                    budgetService.budget = budget;
                  },
                ),
              );
            },
          ),
        ],
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
