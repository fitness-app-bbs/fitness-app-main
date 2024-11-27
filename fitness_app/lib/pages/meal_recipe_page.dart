import 'package:FitnessApp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MealRecipePage extends StatelessWidget {
  final String recipeName;
  final String imagePath;
  final int kcal;
  final String time;

  const MealRecipePage({
    Key? key,
    required this.recipeName,
    required this.imagePath,
    required this.kcal,
    required this.time,
  }) : super(key: key);

  Future<Map<String, dynamic>> _loadRecipeData() async {
    final String jsonString = await rootBundle.loadString('assets/json/recipes.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadRecipeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading recipe data"));
        } else {
          final recipe = (snapshot.data!['recipes'] as List)
              .firstWhere((item) => item['name'] == recipeName, orElse: () => null);

          if (recipe == null) {
            return Center(child: Text("Recipe not found"));
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor(brightness),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.textColor(brightness)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                recipeName,
                style: TextStyle(color: AppColors.textColor(brightness), fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Image of the meal at the top
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(recipe['imagePath']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          recipeName,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${recipe['kcal']} kcal • ${recipe['time']}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 20),
                        _buildDetailsSection('Ingredients', recipe['ingredients']),
                        SizedBox(height: 20),
                        _buildDetailsSection('Instructions', recipe['instructions']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildDetailsSection(String title, List<dynamic> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details
              .asMap()
              .entries
              .map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('${entry.key + 1}. ${entry.value}'),
          ))
              .toList(),
        ),
      ],
    );
  }
}