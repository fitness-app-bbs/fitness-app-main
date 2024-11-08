import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:FitnessApp/utils/colors.dart';
import 'meal_recipe_page.dart';
import 'calorie_calculator_page.dart';


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

class NutritionDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          // Main content area
          Column(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: height * 0.25,
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Moved the button here
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalorieCalculatorPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Calculate Your Calorie Requirement',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
              SizedBox(height: 24),
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
                        _mealCard(context, 'Fruit Granola', 271, '10 min', 'assets/images/fruit_granola.png'),
                        _mealCard(context, 'Pesto Pasta', 512, '15 min', 'assets/images/pesto_pasta.png'),
                        _mealCard(context, 'Greek Yogurt Parfait', 200, '5 min', 'assets/images/greek_yogurt_parfait.png'),
                        _mealCard(context, 'Quinoa Salad', 290, '10 min', 'assets/images/quinoa_salad.png'),
                        _mealCard(context, 'Protein Smoothie', 180, '7 min', 'assets/images/protein_smoothie.png'),
                        _mealCard(context, 'Keto Salad', 415, '12 min', 'assets/images/keto_salad.png'),
                        _mealCard(context, 'Avocado Toast', 250, '5 min', 'assets/images/avocado_toast.png'),
                        _mealCard(context, 'Chicken Caesar Salad', 470, '12 min', 'assets/images/chicken_caesar_salad.png'),
                        _mealCard(context, 'Grilled Salmon', 320, '20 min', 'assets/images/grilled_salmon.png'),
                        _mealCard(context, 'Vegan Buddha Bowl', 350, '15 min', 'assets/images/vegan_buddha_bowl.png'),
                        _mealCard(context, 'Turkey Wrap', 310, '8 min', 'assets/images/turkey_wrap.png'),
                        _mealCard(context, 'Chicken Stir Fry', 450, '18 min', 'assets/images/chicken_stir_fry.png'),
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
            child: SearchBar(),
          ),
        ],
      ),
    );
  }

  Widget _mealCard(BuildContext context, String name, int kcal, String time, String imagePath) {
  return Container(
    decoration: _buildBoxDecorationWithShadow(),
    margin: EdgeInsets.symmetric(vertical: 8),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealRecipePage(
              name: name,
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
  BoxDecoration _buildBoxDecorationWithShadow() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          spreadRadius: 4,
          blurRadius: 4,
          offset: Offset(0, 4),
        ),
      ],
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
                    color: AppColors.dark,
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "kcal left",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dark,
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