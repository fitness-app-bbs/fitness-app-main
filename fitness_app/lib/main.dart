import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'pages/auth_page.dart';
import 'pages/homepage.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'utils/colors.dart';
import 'pages/leaderboard.dart';
import 'pages/workouts.dart';
import 'pages/nutrition.dart';
import 'pages/calorie_calculator_page.dart';
import 'pages/meal_recipe_page.dart';
import 'pages/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => AuthPage(),
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

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(onTileTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      }),
      MainWorkoutScreen(),
      NutritionDashboard(),
      LeaderboardPage(),
      CalorieCalculatorPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: CustomNavBarTheme.theme,
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
              selectedIcon: Icon(Icons.sports_rounded),
              icon: Icon(Icons.sports_outlined),
              label: 'Workouts',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.fastfood_rounded),
              icon: Icon(Icons.fastfood_outlined),
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
