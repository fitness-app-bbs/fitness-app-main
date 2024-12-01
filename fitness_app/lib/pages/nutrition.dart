import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:FitnessApp/utils/colors.dart';
import 'meal_recipe_page.dart';
import 'calorie_calculator_page.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


double radians(double degrees) {
  return degrees * (math.pi / 180);
}

// Define the SearchBar widget
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor(brightness),
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

class NutritionDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final brightness = Theme.of(context).brightness;

    int athlete_weight = 63;

    // daily
    int calorie_req = 2200;
    int protein_req = (1.6 * athlete_weight).round();
    int carbs_req = 245;
    int fat_req = 84;

    int curr_calories = 1500;
    int curr_protein = 54;
    int curr_carbs = 224;
    int curr_fat = 60;

    double protein_progress = curr_protein / protein_req;
    double carbs_progress = curr_carbs / carbs_req;
    double fat_progress = curr_fat / fat_req;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(brightness),
      body: Stack(
        children: <Widget>[
          // Main content area
          Column(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: height * 0.25,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor(brightness),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.only(top: 30, left: 32, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        _RadialProgress(
                          width: width * 0.4,
                          height: width * 0.4,
                          progress: 0.7,
                          curr_calories: curr_calories,
                          calorie_req: calorie_req,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _IngredientProgress(
                              ingredient: "Protein",
                              progress: protein_progress,
                              progressColor: Colors.green,
                              leftAmount: protein_req - curr_protein,
                              width: width * 0.28,
                            ),
                            SizedBox(height: 10),
                            _IngredientProgress(
                              ingredient: "Carbs",
                              progress: carbs_progress,
                              progressColor: Colors.red,
                              leftAmount: carbs_req - curr_carbs,
                              width: width * 0.28,
                            ),
                            SizedBox(height: 10),
                            _IngredientProgress(
                              ingredient: "Fat",
                              progress: fat_progress,
                              progressColor: Colors.yellow,
                              leftAmount: fat_req - curr_fat,
                              width: width * 0.28,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Scrollable Meals for Today Section
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'MEALS FOR TODAY',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: _loadMealsFromJson(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error loading meals'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('No meals available'));
                            } else {
                              final meals = snapshot.data!;
                              return Column(
                                children: meals.map((meal) {
                                  return _mealCard(
                                    context,
                                    meal['name'],
                                    meal['kcal'],
                                    meal['time'],
                                    meal['imagePath'],
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: SearchBar(), // Ensure this SearchBar widget is implemented
          ),
        ],
      ),
    );
  }

  Widget _mealCard(BuildContext context, String name, int kcal, String time, String imagePath) {
    final brightness = Theme.of(context).brightness;
    return Container(
      decoration: _buildBoxDecorationWithShadow(brightness),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealRecipePage(
                recipeName: name,
                imagePath: imagePath,
                kcal: kcal,
                time: time,
              ),
            ),
          );
        },
        child: ListTile(
          leading: Image.asset(imagePath, width: 50, height: 50),
          title: Text(name),
          subtitle: Text('$kcal kcal • $time'),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecorationWithShadow(Brightness brightness) {
    return BoxDecoration(
      color: brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        if (brightness == Brightness.light)
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _loadMealsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/json/recipes.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return List<Map<String, dynamic>>.from(jsonData['recipes']);
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
                    color: AppColors.lightGray,
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
  final int curr_calories, calorie_req;

  const _RadialProgress({
    Key? key,
    required this.height,
    required this.width,
    required this.progress,
    required this.curr_calories,
    required this.calorie_req,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return CustomPaint(
      painter: _RadialPainter(
        progress: progress,
        brightness: brightness,
        curr_calories: curr_calories,
        calorie_req: calorie_req,
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
                  text: (calorie_req - curr_calories).toString(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor(brightness),
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "kcal left",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor(brightness),
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
  final Brightness brightness;
  final int curr_calories, calorie_req;

  _RadialPainter({
    required this.progress,
    required this.brightness,
    required this.curr_calories,
    required this.calorie_req,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = AppColors.primaryColor(brightness)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * (curr_calories/calorie_req);
    paint.color = AppColors.lightGray;;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      radians(-90),
      radians(360),
      false,
      paint,
    );
    paint.color = AppColors.primaryColor(brightness);
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