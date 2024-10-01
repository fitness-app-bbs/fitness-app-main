import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';

class CalorieCalculatorPage extends StatefulWidget {
  @override
  _CalorieCalculatorPageState createState() => _CalorieCalculatorPageState();
}

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'male';
  String _selectedActivity = 'sedentary';
  double _caloriesNeeded = 0;

  void _calculateCalories() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    int age = int.tryParse(_ageController.text) ?? 0;
    double bmr;

    if (_selectedGender == 'male') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    switch (_selectedActivity) {
      case 'sedentary':
        _caloriesNeeded = bmr * 1.2;
        break;
      case 'lightly active':
        _caloriesNeeded = bmr * 1.375;
        break;
      case 'moderately active':
        _caloriesNeeded = bmr * 1.55;
        break;
      case 'very active':
        _caloriesNeeded = bmr * 1.725;
        break;
      case 'extra active':
        _caloriesNeeded = bmr * 1.9;
        break;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calorie Requirement',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            DropdownButton<String>(
              value: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              items: ['male', 'female'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _selectedActivity,
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value!;
                });
              },
              items: [
                'sedentary',
                'lightly active',
                'moderately active',
                'very active',
                'extra active'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCalories,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            if (_caloriesNeeded > 0)
              Text(
                'Your daily calorie requirement is ${_caloriesNeeded.toStringAsFixed(2)} kcal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
