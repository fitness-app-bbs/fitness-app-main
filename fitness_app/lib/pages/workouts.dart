import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  final List<Map<String, String>> workouts = [
    {'name': 'Weight Training', 'icon': 'assets/images/weight.png'},
    {'name': 'Treadmill', 'icon': 'assets/images/treadmill.png'},
    {'name': 'Boxing', 'icon': 'assets/images/boxing.png'},
    {'name': 'Training Records', 'icon': 'assets/images/training.png'},
    {'name': 'Back', 'icon': 'assets/images/back.png'},
    {'name': 'Cycling', 'icon': 'assets/images/cycling.png'},
    {'name': 'Running', 'icon': 'assets/images/running.png'},
    {'name': 'Swimming', 'icon': 'assets/images/swimming.png'},
    {'name': 'Tennis', 'icon': 'assets/images/tennis.png'},
    {'name': 'Football', 'icon': 'assets/images/football.png'},
    {'name': 'Waterrowing', 'icon': 'assets/images/waterrowing.png'},
    {'name': 'HIT', 'icon': 'assets/images/hit.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            return WorkoutCard(
              name: workouts[index]['name']!,
              iconPath: workouts[index]['icon']!,
            );
          },
        ),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final String name;
  final String iconPath;

  WorkoutCard({required this.name, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 50, width: 50),
          SizedBox(height: 10),
          Text(name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}