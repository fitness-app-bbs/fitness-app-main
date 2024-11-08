import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FitnessApp/utils/colors.dart';

class Workout {
  final String name;
  final String iconUrl;
  final String description;
  final String howToPerform;
  final String variants;
  final String imageUrl;

  Workout({
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.howToPerform,
    required this.variants,
    required this.imageUrl,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      description: json['description'] as String,
      howToPerform: (json['instruction']['howToPerform'] as List<dynamic>?)
          ?.join('\n') ?? '',
      variants: (json['instruction']['variants'] as List<dynamic>?)
          ?.join('\n') ?? '',
      imageUrl: json['imageUrl'] as String,
    );
  }
}

class MainWorkoutScreen extends StatefulWidget {
  @override
  _MainWorkoutScreenState createState() => _MainWorkoutScreenState();
}

class _MainWorkoutScreenState extends State<MainWorkoutScreen> {
  List<Workout> workouts = [];
  bool isLoading = true;
  int currentIndex = 0;
  Workout? selectedWorkout;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final workoutFiles = [
      'assets/json/workouts/ball_bounce.json',
      'assets/json/workouts/bench_press.json',
      'assets/json/workouts/crunch.json',
      'assets/json/workouts/deadlift.json',
      'assets/json/workouts/dumbbell_press.json',
      'assets/json/workouts/lunges.json',
      'assets/json/workouts/push_ups.json',
      'assets/json/workouts/squats.json',
      'assets/json/workouts/treadmill.json',
      'assets/json/workouts/tricep_extensions.json',
      'assets/json/workouts/triceps_dips.json',
    ];

    for (final file in workoutFiles) {
      final String response = await rootBundle.loadString(file);
      final data = await json.decode(response);
      workouts.add(Workout.fromJson(data));
    }

    setState(() {
      isLoading = false;
    });
  }

  void navigateToDetail(Workout workout) {
    setState(() {
      selectedWorkout = workout;
      currentIndex = 1;
    });
  }

  void goBackToMain() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : IndexedStack(
        index: currentIndex,
        children: [
          WorkoutPage(workouts: workouts, onWorkoutSelected: navigateToDetail),
          if (selectedWorkout != null)
            WorkoutDetailPage(workout: selectedWorkout!, onBack: goBackToMain),
        ],
      ),
    );
  }
}

class WorkoutPage extends StatelessWidget {
  final List<Workout> workouts;
  final Function(Workout) onWorkoutSelected;

  WorkoutPage({required this.workouts, required this.onWorkoutSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: GridView.builder(
        padding: const EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0, bottom: 16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return GestureDetector(
            onTap: () => onWorkoutSelected(workout),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(workout.iconUrl, height: 120, fit: BoxFit.contain),
                  SizedBox(height: 10),
                  Text(
                    workout.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



class WorkoutDetailPage extends StatelessWidget {
  final Workout workout;
  final VoidCallback onBack;

  WorkoutDetailPage({required this.workout, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(workout.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  workout.imageUrl,
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                workout.name,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.infoCircle, color: Colors.red), // Updated icon
                  SizedBox(width: 8),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.red[50], // Light red color
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    workout.description,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),

              // How to Perform Section
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.playCircle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    "How to Perform",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.green[50],
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    workout.howToPerform,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),

              // Variants Section
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.list, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Variants",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.orange[50],
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    workout.variants,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
