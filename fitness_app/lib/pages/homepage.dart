import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:FitnessApp/pages/settings.dart';
import 'package:FitnessApp/pages/workouts.dart';
import 'package:FitnessApp/pages/nutrition.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/services.dart' show rootBundle;

double radians(double degrees) {
  return degrees * (math.pi / 180);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? localizedStrings;

  @override
  void initState() {
    super.initState();
    _loadLocalizedStrings();
  }

  Future<void> _loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString('assets/json/homepage.json');
    setState(() {
      localizedStrings = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (localizedStrings == null) {
      return Center(child: CircularProgressIndicator());
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(localizedStrings!['homepage_title']),
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
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
              SizedBox(height: 32),

              // Activity Summary Section
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NutritionDashboard()),
                      );
                    },
                    child: Expanded(
                      flex: 40,
                      child: Container(
                        height: 200,
                        child: _RadialProgress(
                          width: width * 0.4,
                          height: width * 0.4,
                          progress: localizedStrings!['radial_progress_value'],  // Load progress from JSON
                          kcalLeft: localizedStrings!['radial_progress_kcal'],   // Load kcal text from JSON
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 100,
                    child: Column(
                      children: [
                        Container(
                          height: 92,
                          child: _buildActivityCardRight(
                              localizedStrings!['in_progress_title'],
                              localizedStrings!['in_progress_count'],
                              localizedStrings!['in_progress_workouts'],
                              Icons.autorenew, Colors.blue
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 92,
                          child: _buildActivityCardRight(
                              localizedStrings!['time_spent_title'],
                              localizedStrings!['time_spent_count'],
                              localizedStrings!['time_spent_minutes'],
                              Icons.timer, Colors.purple
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              _buildProgressCard(
                localizedStrings!['progress_title'],
                localizedStrings!['progress_message'],
              ),

              SizedBox(height: 30),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WorkoutPage()),
                        );
                      },
                      child: _buildWorkoutCard(
                        localizedStrings!['workout_card_cardio'],
                        localizedStrings!['workout_card_cardio_exercises'],
                        localizedStrings!['workout_card_cardio_time'],
                        Colors.orange,
                        'assets/images/crunch.png',
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WorkoutPage()),
                        );
                      },
                      child: _buildWorkoutCard(
                        localizedStrings!['workout_card_arms'],
                        localizedStrings!['workout_card_arms_exercises'],
                        localizedStrings!['workout_card_arms_time'],
                        Colors.indigo,
                        'assets/images/bench_press.png',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NutritionDashboard()),
                        );
                      },
                      child: _buildFoodCard(
                        localizedStrings!['food_card_fruit_granola'],
                        Colors.orange,
                        'assets/images/fruit_granola.png',
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NutritionDashboard()),
                        );
                      },
                      child: _buildFoodCard(
                        localizedStrings!['food_card_pesto_pasta'],
                        Colors.indigo,
                        'assets/images/pesto_pasta.png',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }



Widget _buildActivityCardLeft(String title, String count, String subtitle, IconData icon, Color color) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the contents horizontally
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center, // Center align the subtitle
            style: TextStyle(
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActivityCardRight(String title, String count, String subtitle, IconData icon, Color color) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(16),
      width: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the contents
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
      width: 240, // Adjust the width to fit more content
      decoration: _buildBoxDecoration().copyWith(color: color),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          // Text on the left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text color
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  exercises,
                  style: TextStyle(
                    color: Colors.white, // White text color
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white, // White text color
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16), // Space between text and image

          // Image on the right
          Image.asset(imagePath, height: 120, fit: BoxFit.cover),
        ],
      ),
    );
  }


  Widget _buildFoodCard(String title, Color color, String imagePath) {
    return Container(
      width: 240, // Adjust the width to fit more content
      decoration: _buildBoxDecoration().copyWith(color: color),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [

          // Text on the left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text color
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(height: 30), // Space between text and image
          //SizedBox(width: 30), // Space between text and image

          // Image on the right
          Image.asset(imagePath, height: 80, fit: BoxFit.cover),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String subtitle) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.emoji_events, size: 32, color: Colors.orange),
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
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress;
  final String kcalLeft; // Add kcalLeft parameter

  const _RadialProgress({
    Key? key,
    required this.height,
    required this.width,
    required this.progress,
    required this.kcalLeft, // Initialize kcalLeft
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(16),
      width: 200,
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
                    text: kcalLeft.split(" ")[0],  // Extract the kcal number from the text
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF200087),
                    ),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: kcalLeft.split(" ")[1] + " " + kcalLeft.split(" ")[2], // Extract "kcal left"
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
