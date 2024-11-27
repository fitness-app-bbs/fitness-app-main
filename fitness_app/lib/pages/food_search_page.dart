import 'package:flutter/material.dart';

class FoodDetailPage extends StatelessWidget {
  final Map<String, dynamic> foodData;

  FoodDetailPage({required this.foodData});

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(foodData['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutritional Information (per 100g)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Calories: ${foodData['calories']} kcal'),
            Text('Protein: ${foodData['protein']} g'),
            Text('Carbs: ${foodData['carbs']} g'),
            Text('Fat: ${foodData['fat']} g'),
            SizedBox(height: 20),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter quantity (grams)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int quantity = int.parse(quantityController.text);
                double factor = quantity / 100;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NutritionResultPage(
                      foodData: foodData,
                      factor: factor,
                    ),
                  ),
                );
              },
              child: Text('Calculate Nutritional Values'),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionResultPage extends StatelessWidget {
  final Map<String, dynamic> foodData;
  final double factor;

  NutritionResultPage({required this.foodData, required this.factor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${['name']} Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutritional Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Calories: ${(foodData['calories'] * factor).toStringAsFixed(2)} kcal'),
            Text('Protein: ${(foodData['protein'] * factor).toStringAsFixed(2)} g'),
            Text('Carbs: ${(foodData['carbs'] * factor).toStringAsFixed(2)} g'),
            Text('Fat: ${(foodData['fat'] * factor).toStringAsFixed(2)} g'),
          ],
        ),
      ),
    );
  }
}
