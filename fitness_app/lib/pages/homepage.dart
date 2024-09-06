import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                decoration: _buildBoxDecoration(),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                      AssetImage('assets/images/profile.png'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Jane',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Let\'s check your activity',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Activity Summary Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActivityCard('Finished', '12', 'Completed Workouts', Icons.check_circle, Colors.orange),
                  _buildActivityCard('In progress', '2', 'Workouts', Icons.autorenew, Colors.blue),
                  _buildActivityCard('Time spent', '62', 'Minutes', Icons.timer, Colors.purple),
                ],
              ),
              SizedBox(height: 32),

              // Discover New Workouts Section
              Text(
                'Discover new workouts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  _buildWorkoutCard('Cardio', '10 Exercises', '50 Minutes', Colors.yellow, 'assets/images/cardio.png'),
                  SizedBox(width: 16),
                  _buildWorkoutCard('Arms', '6 Exercises', '35 Minutes', Colors.lightBlueAccent, 'assets/images/arms.png'),
                ],
              ),
              SizedBox(height: 32),

              // Progress Section
              _buildProgressCard('Keep the progress!', 'You are more successful than 88% users'),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 4,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildActivityCard(String title, String count, String subtitle, IconData icon, Color color) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(22),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(String title, String exercises, String time, Color color, String imagePath) {
    return Expanded(
      child: Container(
        decoration: _buildBoxDecoration().copyWith(color: color),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, height: 100, fit: BoxFit.cover), // Update with actual image path
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(exercises),
            Text(time),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, String subtitle) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.emoji_events, size: 32, color: Colors.orange),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
