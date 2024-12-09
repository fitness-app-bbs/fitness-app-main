import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:FitnessApp/pages/settings.dart';
import 'package:FitnessApp/pages/workouts.dart';
import 'package:FitnessApp/pages/nutrition.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  final Function(int) onTileTap;

  HomePage({required this.onTileTap});

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  Map<String, dynamic>? localizedStrings;
  Stream<StepCount>? _stepCountStream;
  Stream<PedestrianStatus>? _pedestrianStatusStream;
  int _steps = 0;
  String _pedestrianStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initializePedometer();
    _requestActivityPermission();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadLocalizedStrings();
  }

  Future<void> _requestActivityPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _initializePedometer();
    } else {
      print("Berechtigung für körperliche Aktivität wurde verweigert.");
    }
  }


  Future<void> _loadLocalizedStrings() async {
    final locale = Localizations.localeOf(context);
    String jsonString;

    try {
      if (locale.languageCode == 'de') {
        jsonString = await rootBundle.loadString('assets/json/homepage_de.json');
        await initializeDateFormatting('de_DE', null);
      } else {
        jsonString = await rootBundle.loadString('assets/json/homepage_en.json');
        await initializeDateFormatting('en_US', null);
      }

      setState(() {
        localizedStrings = json.decode(jsonString);
      });
    } catch (e) {
      print("Error: Failed to load json file $e");
    }
  }

  void _initializePedometer() {
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Initialize streams
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _stepCountStream = await Pedometer.stepCountStream;

    // Listen to step count stream
    _stepCountStream!.listen(onStepCount).onError(onStepCountError);

    // Listen to pedestrian status stream
    _pedestrianStatusStream!
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _pedestrianStatus = event.status;
    });
  }

  void onStepCountError(error) {
    print("Pedometer Error: $error");
    setState(() {
      _steps = 0;
    });
  }

  void onPedestrianStatusError(error) {
    print("Pedestrian Status Error: $error");
    setState(() {
      _pedestrianStatus = 'Unknown';
    });
  }
  void _goToSettingsPage() {
    setState(() {
      _currentIndex = 1;
    });
  }

  void _goBackToHomePage() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (localizedStrings == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(brightness),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeContent(brightness),
          SettingsPage(onBack: _goBackToHomePage),
        ],
      ),
    );
  }

  Widget _buildHomeContent(Brightness brightness) {
    final locale = Localizations.localeOf(context).toString();
    final brightness = Theme.of(context).brightness;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            GestureDetector(
              onTap: _goToSettingsPage,
              child: Container(
                decoration: _buildBoxDecoration(brightness),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/haley_image.png'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizedStrings!['greeting'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${DateFormat(localizedStrings!['current_day'], locale).format(DateTime.now())}, ${DateFormat(localizedStrings!['current_date'], locale).format(DateTime.now())}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Other UI components
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onTileTap(2);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.44, // 45% width
                    height: 200,
                    decoration: _buildBoxDecoration(brightness), // Apply the box decoration here
                    child: Stack(
                      children: [
                        Center(
                          child: RadialProgress(
                            width: MediaQuery.of(context).size.width * 0.38,
                            height: MediaQuery.of(context).size.width * 0.38,
                            progress: 0,
                            curr_calories: NutritionDashboard.curr_calories,
                            calorie_req: NutritionDashboard.calorie_req,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onTileTap(2);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.44, // 45% width
                    height: 200,
                    child: StepCounter(
                      width: MediaQuery.of(context).size.width * 0.5, // Ensure it matches the container width
                      height: MediaQuery.of(context).size.width * 0.5, // Ensure it matches the container height
                      steps: _steps,
                      pedestrianStatus: _pedestrianStatus,
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                widget.onTileTap(3);
              },
              child: _buildProgressCard(
                localizedStrings!['progress_title'],
                localizedStrings!['progress_message'],
              ),
            ),

            SizedBox(height: 20),

            _buildHorizontalScrollView(context),
          ],
        ),
      ),
    );
  }



Widget _buildHorizontalScrollView(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildWorkoutCard(
                localizedStrings!['workout_card_cardio'],
                localizedStrings!['workout_card_cardio_exercises'],
                localizedStrings!['workout_card_cardio_time'],
                Colors.orange,
                'assets/images/crunch.png',
              ),
              SizedBox(width: 16),
              _buildWorkoutCard(
                localizedStrings!['workout_card_arms'],
                localizedStrings!['workout_card_arms_exercises'],
                localizedStrings!['workout_card_arms_time'],
                Colors.indigo,
                'assets/images/bench_press.png',
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFoodCard(
                localizedStrings!['food_card_fruit_granola'],
                Colors.orange,
                'assets/images/fruit_granola.png',
              ),
              SizedBox(width: 16),
              _buildFoodCard(
                localizedStrings!['food_card_pesto_pasta'],
                Colors.indigo,
                'assets/images/pesto_pasta.png',
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildActivityCardRight(String title, String count, String subtitle, IconData icon, Color color) {
    final brightness = Theme.of(context).brightness;
    return Container(
      decoration: _buildBoxDecoration(brightness),
      padding: EdgeInsets.all(16),
      width: 220,
      height: 92,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 25, color: color),
          SizedBox(width: 15),
          Text(
            count,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(String title, String exercises, String time, Color color, String imagePath) {
    final brightness = Theme.of(context).brightness;
    return Container(
      width: 240,
      decoration: _buildBoxDecoration(brightness).copyWith(color: color),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  exercises,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Image.asset(
            imagePath,
            height: 120,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(String title, Color color, String imagePath) {
    final brightness = Theme.of(context).brightness;
    return Container(
      width: 240,
      decoration: _buildBoxDecoration(brightness).copyWith(color: color),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(height: 30),
          Image.asset(
            imagePath,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String message) {
    final brightness = Theme.of(context).brightness;
    return Container(
      decoration: _buildBoxDecoration(brightness),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.trending_up, color: Colors.green, size: 32),
          SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.7),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: AppColors.gray,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class StepCounter extends StatelessWidget {
  final double height, width;
  final int steps;
  final String pedestrianStatus;

  const StepCounter({
    Key? key,
    required this.height,
    required this.width,
    required this.steps,
    required this.pedestrianStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      decoration: _buildBoxDecoration(brightness),
      padding: EdgeInsets.all(16),
      width: width,
      height: height,
      child: Stack(
        children: [
          // Center the content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_walk,
                  size: 50,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 8),
                Text(
                  steps.toString(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Status: $pedestrianStatus",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}


BoxDecoration _buildBoxDecoration(Brightness brightness) {
  return BoxDecoration(
    color: AppColors.cardColor(brightness),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 4,
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
  );
}