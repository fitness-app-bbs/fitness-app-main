import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FitnessApp/utils/colors.dart';

class Workout {
  final Map<String, String> name;
  final String iconUrl;
  final Map<String, String> description;
  final Map<String, List<String>> howToPerform;
  final Map<String, List<String>> variants;
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
      name: Map<String, String>.from(json['name']),
      iconUrl: json['iconUrl'] as String,
      description: Map<String, String>.from(json['description']),
      howToPerform: (json['instruction']['howToPerform'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, List<String>.from(value))),
      variants: (json['instruction']['variants'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, List<String>.from(value))),
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
    for (var workout in workouts) {
      precacheImage(AssetImage(workout.iconUrl), context);
    }
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

    final loadedWorkouts = <Workout>[];
    for (final file in workoutFiles) {
      final String response = await rootBundle.loadString(file);
      final data = json.decode(response);
      loadedWorkouts.add(Workout.fromJson(data));
    }

    setState(() {
      workouts = loadedWorkouts;
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
    final locale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : IndexedStack(
        index: currentIndex,
        children: [
          WorkoutPage(workouts: workouts, onWorkoutSelected: navigateToDetail, locale: locale),
          if (selectedWorkout != null)
            WorkoutDetailPage(
              workout: selectedWorkout!,
              onBack: goBackToMain,
              currentLanguage: locale,
            ),
        ],
      ),
    );
  }
}

class WorkoutPage extends StatelessWidget {
  final List<Workout> workouts;
  final Function(Workout) onWorkoutSelected;
  final String locale;

  WorkoutPage({required this.workouts, required this.onWorkoutSelected, required this.locale});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(brightness),

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
                    workout.name[locale] ?? workout.name['en'] ?? 'No name',
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
  final String currentLanguage;

  WorkoutDetailPage({
    required this.workout,
    required this.onBack,
    required this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(brightness),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor(brightness),
        title: Text(workout.name[currentLanguage] ?? workout.name['en'] ?? 'No translation available'),
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
                workout.name[currentLanguage] ?? workout.name['en']!,
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textColor(brightness)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                color: AppColors.workoutDescriptionColor(brightness), // Light red color
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    workout.description[currentLanguage] ?? workout.description['en']!,
                    style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textColor(brightness)),
                  ),
                ),
              ),

              // How to Perform Section
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.playCircle, color: AppColors.green),
                  SizedBox(width: 8),
                  Text(
                    "How to Perform",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textColor(brightness)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                color: AppColors.workoutPerformColor(brightness),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    (workout.howToPerform[currentLanguage] ?? workout.howToPerform['en']!).join('\n'),
                    style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textColor(brightness)),
                  ),
                ),
              ),

              // Variants Section
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.list, color: AppColors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Variants",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textColor(brightness)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                color: AppColors.workoutVariantsColor(brightness),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    (workout.variants[currentLanguage] ?? workout.variants['en']!).join('\n'),
                    style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textColor(brightness)),
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
