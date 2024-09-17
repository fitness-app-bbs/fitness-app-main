import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:FitnessApp/pages/settings.dart';
import 'package:FitnessApp/pages/workouts.dart';
import 'package:FitnessApp/pages/nutrition.dart';
import 'dart:math' as math;

double radians(double degrees) {
  return degrees * (math.pi / 180);
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Homepage"),
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
                        backgroundImage:
                        AssetImage('assets/images/haley_image.png'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Haley',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Let\'s check your activity',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray,
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
                  // The first card takes 45% of the width
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NutritionDashboard()),
                      );
                    },
                    child: Expanded(
                      flex: 40, // This will take 40% of the available width
                      child: Container(
                        height: 200, // Set a fixed height for the cards
                        child: _RadialProgress(
                          width: width * 0.4,
                          height: width * 0.4,
                          progress: 0.7,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 16), // Reduced the space between the columns

                  // The right column takes the remaining 55% with two wider cards
                  Expanded(
                    flex: 100, // This will take 55% of the available width
                    child: Column(
                      children: [
                        Container(
                          height: 92, // Set height to take up half of the parent's height
                          child: _buildActivityCardRight(
                              'In progress', ' 2', ' Workouts',
                              Icons.autorenew, Colors.blue
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 92, // Set height to take up half of the parent's height
                          child: _buildActivityCardRight(
                              'Time spent', ' 62', ' Minutes',
                              Icons.timer, Colors.purple
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),



              _buildProgressCard('Keep the progress!', 'You are more successful than 40% of your friends'),

              SizedBox(height: 30),


              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WorkoutPage()), // Replace with your target page
                        );
                      },
                      child: _buildWorkoutCard(
                        'Cardio',
                        '10 Exercises',
                        '50 Minutes',
                        Colors.orange,
                        'assets/images/crunch.png',
                      ),
                    ),
                    SizedBox(width: 16), // Space between cards
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WorkoutPage()), // Replace with your target page
                        );
                      },
                      child: _buildWorkoutCard(
                        'Arms',
                        '6 Exercises',
                        '35 Minutes',
                        Colors.indigo,
                        'assets/images/bench_press.png',
                      ),

                    ),

                  ],
                ),
              ),


              SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NutritionDashboard()), // Replace with your target page
                        );
                      },
                      child: _buildFoodCard(
                        'Fruit Granola',
                        Colors.orange,
                        'assets/images/fruit_granola.png',
                      ),
                    ),
                    SizedBox(width: 16), // Space between cards
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NutritionDashboard()), // Replace with your target page
                        );
                      },
                      child: _buildFoodCard(
                        'Pesto Pasta',
                        Colors.indigo,
                        'assets/images/pesto_pasta.png',
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 32),

              // Progress Section
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
      padding: EdgeInsets.all(16),  // This will create padding around the progress
      width: 200,  // Keep a fixed width for the container
      height: height,
      child: Stack(  // Use Stack to layer the CustomPaint and the content
        children: [
          CustomPaint(
            painter: _RadialPainter(progress: progress),
            size: Size(width, height),  // Define the size for the radial progress
          ),
          Center(  // Center the content on top of the radial progress
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
