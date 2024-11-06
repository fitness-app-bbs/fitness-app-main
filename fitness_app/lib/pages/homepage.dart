import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:FitnessApp/pages/settings.dart';
import 'package:FitnessApp/pages/workouts.dart';
import 'package:FitnessApp/pages/nutrition.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
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
    _loadLocalizedStrings();
    _initializePedometer();
    _requestActivityPermission();
  }

  Future<void> _requestActivityPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _initializePedometer();
    } else {
      print("Berechtigung für körperliche Aktivität wurde verweigert.");
    }
  }


  Future<void> _loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString('assets/json/homepage.json');
    setState(() {
      localizedStrings = json.decode(jsonString);
    });
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
    if (localizedStrings == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(localizedStrings!['homepage_title']),
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeContent(),
          SettingsPage(onBack: _goBackToHomePage),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _goToSettingsPage,
              child: Container(
                decoration: _buildBoxDecoration(),
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
                          "${DateFormat(localizedStrings!['current_day']).format(DateTime.now())}, ${DateFormat(localizedStrings!['current_date']).format(DateTime.now())}",
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
                    child: _RadialProgress(
                      width: MediaQuery.of(context).size.width * 0.5, // Ensure it matches the container width
                      height: MediaQuery.of(context).size.width * 0.5, // Ensure it matches the container height
                      progress: 0.7,
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
    return Container(
      decoration: _buildBoxDecoration(),
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
    return Container(
      width: 240,
      decoration: _buildBoxDecoration().copyWith(color: color),
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
    return Container(
      width: 240,
      decoration: _buildBoxDecoration().copyWith(color: color),
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
    return Container(
      decoration: _buildBoxDecoration(),
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
    return Container(
      decoration: _buildBoxDecoration(),
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




class _RadialProgress extends StatelessWidget {
  final double height, width, progress;

  const _RadialProgress({
    Key? key,
    required this.height,
    required this.width,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(16),
      width: width,
      height: height,
      child: Stack(
        children: [
          CustomPaint(
            painter: _RadialPainter(progress: progress),
            size: Size(width, height),
          ),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "1731",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF200087),
                    ),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: "kcal left",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF200087),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = AppColors.dark
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      radians(-90),
      radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

BoxDecoration _buildBoxDecoration() {
  return BoxDecoration(
    color: AppColors.white,
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