import 'package:FitnessApp/utils/colors.dart';
import 'package:flutter/material.dart';

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
}

class WorkoutPage extends StatelessWidget {
  final List<Workout> workouts = [
    Workout(
      name: 'Ball Bounce',
      iconUrl: 'assets/images/ball_bounce.png',
      description: 'The Ball Bounce workout focuses on building strength, balance, and endurance using a weighted medicine ball. This functional training exercise engages your core, arms, and legs as you perform powerful ball slams or bounces. It is perfect for enhancing explosive power, improving coordination, and burning calories through full-body engagement. Ideal for those looking to challenge their athleticism and strength in a dynamic way.',
      instruction: '''
How to Perform:
1. Start with your feet shoulder-width apart, holding a medicine ball in both hands at chest height.
2. Extend your arms and lift the ball overhead.
3. In one explosive motion, slam the ball down onto the floor as hard as possible, engaging your core and bending your knees slightly.
4. Catch the ball on the rebound (if it bounces) or pick it up and repeat.

Variants:
- Side Ball Bounce: Slam the ball to one side of your body, alternating sides.
- Overhead Squat with Ball Bounce: Perform a squat each time you slam the ball.
- Lunge and Bounce: Perform a reverse lunge while bouncing the ball between reps.
''',
      imageUrl: 'assets/images/ball_bounce.png',
    ),
    Workout(
      name: 'Bench Press',
      iconUrl: 'assets/images/bench_press.png',
      description: 'The Bench Press is a classic weightlifting exercise targeting the chest, shoulders, and triceps. This strength-building workout is key for developing upper body power and increasing muscle mass.',
      instruction: '''
How to Perform:
1. Lie flat on a bench with your feet planted firmly on the floor.
2. Grip the barbell with hands slightly wider than shoulder-width apart.
3. Lower the barbell to your chest, ensuring your elbows are at about a 45-degree angle to your body.
4. Press the barbell back up by extending your arms fully without locking out your elbows.

Variants:
- Dumbbell Bench Press: Use dumbbells instead of a barbell to increase stability demands.
- Incline Bench Press: Perform on an incline bench to target the upper chest.
- Decline Bench Press: Use a decline bench to focus on the lower chest.
''',
      imageUrl: 'assets/images/bench_press.png',
    ),
    Workout(
      name: 'Crunch',
      iconUrl: 'assets/images/crunch.png',
      description: 'Crunches are essential for building core strength and toning the abdominal muscles. This exercise isolates the abs while minimizing strain on the lower back.',
      instruction: '''
How to Perform:
1. Lie on your back with your knees bent and feet flat on the floor, hip-width apart.
2. Place your hands behind your head or cross them over your chest.
3. Lift your shoulders off the ground by engaging your core, keeping your lower back in contact with the floor.
4. Hold the contraction at the top for a second before slowly lowering back down.

Variants:
- Bicycle Crunch: Bring your opposite elbow toward your knee while alternating legs in a cycling motion.
- Weighted Crunch: Hold a plate or dumbbell across your chest to increase resistance.
- Reverse Crunch: Lift your knees toward your chest as you curl your hips off the ground.
''',
      imageUrl: 'assets/images/crunch.png',
    ),
    Workout(
      name: 'Deadlift',
      iconUrl: 'assets/images/deadlift.png',
      description: 'The Deadlift is a full-body strength exercise that primarily targets the posterior chain, including your hamstrings, glutes, and lower back.',
      instruction: '''
How to Perform:
1. Stand with your feet hip-width apart, toes under the barbell.
2. Grip the barbell just outside your knees with palms facing down.
3. With a flat back and engaged core, lift the bar by driving through your heels, standing up straight and locking your hips at the top.
4. Lower the bar back down by hinging at your hips, keeping the bar close to your body.

Variants:
- Sumo Deadlift: Use a wider stance and grip the bar between your legs to target the inner thighs and glutes.
- Romanian Deadlift: Focus on the hamstrings by lowering the bar with a slight bend in the knees, keeping the bar close to your shins.
- Single-Leg Deadlift: Perform with one leg to challenge balance and stability.
''',
      imageUrl: 'assets/images/deadlift.png',
    ),
    Workout(
      name: 'Dumbbell Press',
      iconUrl: 'assets/images/dumbbell_press.png',
      description: 'The Dumbbell Press is a versatile strength-building exercise that targets your chest, shoulders, and triceps. Using dumbbells adds an element of instability, engaging your stabilizer muscles more.',
      instruction: '''
How to Perform:
1. Lie on a flat bench, holding a dumbbell in each hand at chest height with palms facing forward.
2. Press the dumbbells up by extending your arms, squeezing your chest at the top.
3. Lower the weights back to your chest with control.

Variants:
- Incline Dumbbell Press: Use an incline bench to shift focus to the upper chest.
- Neutral Grip Dumbbell Press: Hold the dumbbells with palms facing each other to reduce shoulder strain.
- Single-Arm Dumbbell Press: Perform one arm at a time to improve unilateral strength and stability.
''',
      imageUrl: 'assets/images/dumbbell_press.png',
    ),
    Workout(
      name: 'Tricep Extensions',
      iconUrl: 'assets/images/laying_trizep_extensions.png',
      description: 'Tricep Extensions isolate and strengthen the muscles at the back of your arms, helping you build definition and upper body strength.',
      instruction: '''
How to Perform:
1. Hold a dumbbell with both hands, extending your arms straight overhead.
2. Bend your elbows and lower the dumbbell behind your head until your forearms are parallel to the floor.
3. Extend your arms back up to the starting position, focusing on squeezing the triceps.

Variants:
- Skull Crushers: Use an EZ-bar or dumbbells while lying on a bench to target the triceps.
- Cable Tricep Extensions: Use a cable machine with a rope attachment for continuous tension.
- One-Arm Overhead Extension: Perform with one arm for better isolation.
''',
      imageUrl: 'assets/images/laying_trizep_extensions.png',
    ),
    Workout(
      name: 'Lunges',
      iconUrl: 'assets/images/lunges.png',
      description: 'Lunges are an excellent lower-body workout that engages your quads, hamstrings, and glutes. This functional movement also helps to improve balance, flexibility, and core strength.',
      instruction: '''
How to Perform:
1. Stand tall with feet hip-width apart.
2. Step forward with one leg, lowering your hips until both knees are bent at 90-degree angles.
3. Push through the heel of the front foot to return to the starting position, then switch legs.

Variants:
- Walking Lunges: Step forward with alternating legs as you walk across the floor.
- Reverse Lunges: Step backward instead of forward to focus on the glutes and hamstrings.
- Weighted Lunges: Hold dumbbells or a barbell for added resistance.
''',
      imageUrl: 'assets/images/lunges.png',
    ),
    Workout(
      name: 'Push Ups',
      iconUrl: 'assets/images/push_ups.png',
      description: 'Push-Ups are one of the most fundamental and effective bodyweight exercises, targeting the chest, shoulders, triceps, and core.',
      instruction: '''
How to Perform:
1. Start in a plank position with hands slightly wider than shoulder-width apart.
2. Lower your chest to the ground while keeping your core tight and elbows at a 45-degree angle.
3. Push yourself back up to the starting position.

Variants:
- Knee Push-Ups: Perform on your knees for an easier version.
- Decline Push-Ups: Place your feet on an elevated surface to increase difficulty.
- Diamond Push-Ups: Place your hands close together to target the triceps more.
''',
      imageUrl: 'assets/images/push_ups.png',
    ),
    Workout(
      name: 'Squats',
      iconUrl: 'assets/images/squads.png',
      description: 'Squats are a fundamental lower-body exercise that works your quads, hamstrings, glutes, and core. This compound movement improves leg strength, mobility, and overall stability.',
      instruction: '''
How to Perform:
1. Stand with feet shoulder-width apart, toes slightly pointed outward.
2. Push your hips back and bend your knees to lower into a squat position, keeping your chest upright.
3. Drive through your heels to return to the starting position.

Variants:
- Goblet Squat: Hold a dumbbell or kettlebell at chest height to engage the core more.
- Sumo Squat: Widen your stance to target the inner thighs and glutes.
- Jump Squat: Add a jump at the top of the movement to increase intensity and power.
''',
      imageUrl: 'assets/images/squads.png',
    ),
    Workout(
      name: 'Treadmill',
      iconUrl: 'assets/images/treadmill.png',
      description: 'The Treadmill is a staple cardio machine for improving cardiovascular health and endurance. Whether you are walking, jogging, or sprinting, the treadmill allows you to control the intensity and incline for a personalized workout. Track your distance, time, speed, and calories burned to monitor improvements in your stamina and cardiovascular fitness over time.',
      instruction: '''
How to Perform:
1. Start with a walking or jogging pace, adjusting the speed and incline to suit your fitness level.
2. Focus on maintaining proper posture, engaging your core, and using your arms to help drive momentum.

Variants:
- Incline Walk: Increase the incline for a challenging uphill workout without increasing speed.
- HIIT Intervals: Alternate between sprinting and walking to improve cardiovascular endurance.
- Backward Walk: Walk backward at a slow pace to challenge different leg muscles.
''',
      imageUrl: 'assets/images/treadmill.png',
    ),
    Workout(
      name: 'Trizeps Dips',
      iconUrl: 'assets/images/trizeps_dips.png',
      description: 'Tricep Dips are a highly effective bodyweight exercise that targets the triceps, shoulders, and chest. They can be performed using parallel bars, a bench, or even a sturdy chair, making them accessible anywhere. Consistently tracking your reps and sets will help you improve strength and build definition in your upper arms over time.',
      instruction: '''
How to Perform:
1. Sit on the edge of a bench or chair with your hands next to your hips, fingers pointing forward.
2. Slide off the edge, supporting your weight with your arms.
3. Lower your body by bending your elbows until your arms form a 90-degree angle.
4. Push back up to the starting position.

Variants:
- Bench Dips with Feet Elevated: Place your feet on another bench to increase difficulty.
- Parallel Bar Dips: Perform dips on parallel bars for more range of motion and greater difficulty.
- Weighted Dips: Hold a weight plate or dumbbell between your legs for added resistance.
''',
      imageUrl: 'assets/images/trizeps_dips.png',
    ),

    Workout(
      name: 'Trizeps Dips',
      iconUrl: 'assets/images/trizeps_dips.png',
      description: 'Indoor cycling workout to improve leg strength and endurance.',
      instruction: '''
      ''',
      imageUrl: 'assets/images/trizeps_dips.png',
    ),
  ];

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