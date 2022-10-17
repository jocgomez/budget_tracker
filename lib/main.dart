import 'package:budget_tracker/screens/home.dart';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:budget_tracker/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(
          create: (_) => ThemeService(sharedPreferences),
        ),
        ChangeNotifierProvider<BudgetService>(
          create: (_) => BudgetService(),
        ),
      ],
      builder: (context, child) {
        final themeService = context.watch<ThemeService>();

        return MaterialApp(
          title: 'Budget Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo,
              brightness:
                  themeService.darkTheme ? Brightness.dark : Brightness.light,
            ),
          ),
          home: const Home(),
        );
      },
    );
  }
}
