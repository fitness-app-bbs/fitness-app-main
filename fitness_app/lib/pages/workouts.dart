import 'package:flutter/material.dart';

class Workout {
  final String name;
  final String iconUrl;
  final String description;
  final String imageUrl;

  Workout({
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.imageUrl,
  });
}

class WorkoutPage extends StatelessWidget {
  final List<Workout> workouts = [
    Workout(
      name: 'Ball Bounce',
      iconUrl: 'assets/images/ball_bounce.png',
      description: 'A weight training workout to build strength and endurance.',
      imageUrl: 'assets/images/ball_bounce.png',
    ),
    Workout(
      name: 'Bench Press',
      iconUrl: 'assets/images/bench_press.png',
      description: 'Cardio workout on a treadmill to improve stamina and heart health.',
      imageUrl: 'assets/images/bench_press.png',
    ),
    Workout(
      name: 'Crunch',
      iconUrl: 'assets/images/crunch.png',
      description: 'Boxing workout for agility and upper body strength.',
      imageUrl: 'assets/images/crunch.png',
    ),
    Workout(
      name: 'Deadlift',
      iconUrl: 'assets/images/deadlift.png',
      description: 'Track your progress and review past training records.',
      imageUrl: 'assets/images/deadlift.png',
    ),
    Workout(
      name: 'Dumbbell Press',
      iconUrl: 'assets/images/dumbbell_press.png',
      description: 'Exercises focused on strengthening the back muscles.',
      imageUrl: 'assets/images/dumbbell_press.png',
    ),
    Workout(
      name: 'Trizep Extensions',
      iconUrl: 'assets/images/laying_trizep_extensions.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      imageUrl: 'assets/images/laying_trizep_extensions.png',
    ),
    Workout(
      name: 'Lunges',
      iconUrl: 'assets/images/lunges.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      imageUrl: 'assets/images/lunges.png',
    ),
    Workout(
      name: 'Push Ups',
      iconUrl: 'assets/images/push_ups.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      imageUrl: 'assets/images/push_ups.png',
    ),
    Workout(
      name: 'Squads',
      iconUrl: 'assets/images/squads.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      imageUrl: 'assets/images/squads.png',
    ),
    Workout(
      name: 'Treadmill',
      iconUrl: 'assets/images/treadmill.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      imageUrl: 'assets/images/treadmill.png',
    ),
    Workout(
      name: 'Trizeps Dips',
      iconUrl: 'assets/images/trizeps_dips.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      imageUrl: 'assets/images/trizeps_dips.png',
    ),
    Workout(
      name: 'Trizeps Dips',
      iconUrl: 'assets/images/trizeps_dips.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      imageUrl: 'assets/images/trizeps_dips.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
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
                        builder: (context) => WorkoutDetailPage(workout: workout),
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
      appBar: AppBar(
        title: Text(workout.name),
      ),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
