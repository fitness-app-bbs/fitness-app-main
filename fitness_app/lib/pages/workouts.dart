import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:FitnessApp/utils/colors.dart';

class Workout {
  final String name;
  final String iconUrl;
  final String description;
  final String instruction;
  final String imageUrl;

  Workout({
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.instruction,
    required this.imageUrl,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json['name'],
      iconUrl: json['iconUrl'],
      description: json['description'],
      instruction: json['instruction'],
      imageUrl: json['imageUrl'],
    );
  }
}

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Workout> workouts = [];

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
      setState(() {
        workouts.add(Workout.fromJson(data));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Choose a Workout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: workouts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
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
                  onTap: () {
                    // Navigate to the workout details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WorkoutDetailPage(workout: workout),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          workout.iconUrl,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 10),
                        Text(
                          workout.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutDetailPage extends StatelessWidget {
  final Workout workout;

  WorkoutDetailPage({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(workout.name),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                workout.imageUrl,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                workout.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                workout.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                workout.instruction,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
