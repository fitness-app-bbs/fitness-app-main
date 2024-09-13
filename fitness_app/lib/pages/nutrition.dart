import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:FitnessApp/utils/colors.dart';

double radians(double degrees) {
  return degrees * (math.pi / 180);
}

// Define the SearchBar widget
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dark, 
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for food',
            hintStyle: TextStyle(color: AppColors.white),
            prefixIcon: Icon(Icons.search, color: AppColors.white),
            suffixIcon: Icon(Icons.qr_code_scanner, color: AppColors.white),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}

// Main NutritionDashboard widget
class NutritionDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Nutrition Dashboard',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: Stack(
        children: <Widget>[
          // Main content area
          SingleChildScrollView(
            child: Container(
              height: height,
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 40, left: 32, right: 16, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "${DateFormat("EEEE").format(DateTime.now())}, ${DateFormat("d MMMM").format(DateTime.now())}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            "Daily Stats",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                              color: Colors.black,
                            ),
                          ),
                          trailing: ClipOval(
                            child: Image.asset("assets/images/profile.png"),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            _RadialProgress(
                              width: width * 0.4,
                              height: width * 0.4,
                              progress: 0.7,
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _IngredientProgress(
                                  ingredient: "Protein",
                                  progress: 0.3,
                                  progressColor: Colors.green,
                                  leftAmount: 72,
                                  width: width * 0.28,
                                ),
                                SizedBox(height: 10),
                                _IngredientProgress(
                                  ingredient: "Carbs",
                                  progress: 0.2,
                                  progressColor: Colors.red,
                                  leftAmount: 252,
                                  width: width * 0.28,
                                ),
                                SizedBox(height: 10),
                                _IngredientProgress(
                                  ingredient: "Fat",
                                  progress: 0.1,
                                  progressColor: Colors.yellow,
                                  leftAmount: 61,
                                  width: width * 0.28,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Meals for Today Section
                  Text(
                    'MEALS FOR TODAY',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _mealCard('Fruit Granola', 271, '10 min', 'assets/images/fruit_granola.png'),
                  _mealCard('Pesto Pasta', 512, '15 min', 'assets/images/pesto_pasta.png'),
                  _mealCard('Keto Salad', 415, '12 min', 'assets/images/keto_salad.png'),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: SearchBar(),
          ),
        ],
      ),
    );
  }

  Widget _mealCard(String name, int kcal, String time, String imagePath) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50),
        title: Text(name),
        subtitle: Text('$kcal kcal • $time'),
      ),
    );
  }

  Widget _workoutIcon(IconData iconData) {
    return Expanded(
      child: Column(
        children: [
          Icon(iconData, size: 40),
          SizedBox(height: 8),
          Text('Upper Body'),
        ],
      ),
    );
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress({
    Key? key,
    required this.ingredient,
    required this.leftAmount,
    required this.progress,
    required this.progressColor,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text("${leftAmount}g left"),
          ],
        ),
      ],
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
    return CustomPaint(
      painter: _RadialPainter(
        progress: progress,
      ),
      child: Container(
        height: height,
        width: width,
        child: Center(
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
