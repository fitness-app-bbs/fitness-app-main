import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'pages/auth_page.dart';
import 'pages/homepage.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/leaderboard.dart';
import 'pages/workouts.dart';
import 'pages/nutrition.dart';
import 'pages/calorie_calculator_page.dart';
import 'pages/meal_recipe_page.dart';
import 'pages/settings.dart';
import 'utils/colors.dart';
import 'utils/translation_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

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
      child: Consumer<MyAppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            title: 'Fitness App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: appState.themeMode,
            initialRoute: '/auth',
              routes: {
              '/auth': (context) => AuthPage(),
              '/login': (context) => LoginPage(),
              '/signup': (context) => SignUpPage(),
              '/home': (context) => MyHomePage(),
            },
            locale: appState.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('de'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  Locale _locale = Locale('en');
  Locale get locale => _locale;

  final TranslationManager _translationManager = TranslationManager();
  TranslationManager get translationManager => _translationManager;

  MyAppState() {
    _loadThemeMode();
    _loadLocale();
    _loadTranslations();
  }

  void toggleThemeMode() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await _saveThemeMode();
  }

  void changeLocale(String languageCode) async{
    _locale = Locale(languageCode);
    await _translationManager.load(languageCode);
    notifyListeners();
    _saveLocale();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('languageCode') ?? 'en';
    _locale = Locale(langCode);
    await _translationManager.load(langCode);
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }

  Future<void> _saveLocale() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', _locale.languageCode);
  }

  Future<void> _loadTranslations() async {
    await _translationManager.load(_locale.languageCode);
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
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: AppColors.cardColor(brightness),
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: CustomNavBarTheme.theme(brightness),
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
  static NavigationBarThemeData theme(Brightness brightness) {
    return NavigationBarThemeData(
      backgroundColor: AppColors.cardColor(brightness),
      indicatorColor: AppColors.backgroundColor(brightness),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              color: AppColors.textColor(brightness),
              size: 30,
            );
          }
          return IconThemeData(
            color: AppColors.textColor(brightness),
            size: 30,
          );
        },
      ),
      height: 75,
    );
  }
}


