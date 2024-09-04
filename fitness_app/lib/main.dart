import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
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
        page = HomePage(); // Here, HomePage is assigned correctly
        break;
      case 1:
        page = Placeholder(); // You can replace Placeholder with another widget
        break;
      case 2:
        page = Placeholder(); // You can replace Placeholder with another widget
        break;
      case 3:
        page = Placeholder(); // You can replace Placeholder with another widget
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
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
          body: page, // Display the selected page here
        );
      },
    );
  }
}
