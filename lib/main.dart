import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'pages/homepage.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'utils/colors.dart';
import 'pages/leaderboard.dart';
import 'pages/workouts.dart';
import 'pages/nutrition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Fitness App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => MyHomePage(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = WorkoutPage();
        break;
      case 2:
        page = NutritionDashboard();
        break;
      case 3:
        page = LeaderboardPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: NavigationBarTheme(
            data: CustomNavBarTheme.theme,  // Anwenden des Farbschemas
            child: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.sports),
                  icon: Icon(Icons.sports_outlined),
                  label: 'Workouts',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.fastfood_rounded),
                  icon: Icon(Icons.fastfood_rounded),
                  label: 'Nutrition',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.leaderboard),
                  icon: Icon(Icons.leaderboard_outlined),
                  label: 'Leaderboard',
                ),
              ],
            ),
          ),
          body: page,
        );
      },
    );
  }
}

  class CustomNavBarTheme {
    static NavigationBarThemeData get theme {
      return NavigationBarThemeData(
      backgroundColor: AppColors.whitepink,
      indicatorColor: AppColors.lightpink,
      labelTextStyle: MaterialStateProperty.all(TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        )),
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return IconThemeData(
            color: AppColors.black,
          );
        }
        return IconThemeData(
          color: AppColors.black,
          );
        }),
      );
    }
  }

