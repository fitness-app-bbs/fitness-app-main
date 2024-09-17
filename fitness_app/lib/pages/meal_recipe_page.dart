import 'package:flutter/material.dart';

class MealRecipePage extends StatelessWidget {
  final String name;
  final String imagePath;
  final int kcal;
  final String time;

  const MealRecipePage({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.kcal,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                  image: AssetImage(imagePath),
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
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$kcal kcal • $time',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildIngredientsList(name), // Dynamically generated ingredients list
                  SizedBox(height: 20),
                  Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildInstructions(name), // Dynamically generated instructions list
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  // Helper widget to build the ingredients list based on meal name
Widget _buildIngredientsList(String name) {
  List<String> ingredients = [];

  switch (name) {
    case 'Fruit Granola':
      ingredients = [
        "1 cup of oats",
        "1/2 cup of yogurt",
        "1/4 cup of almonds",
        "1 tbsp of honey",
        "1/2 cup of mixed berries",
    ];
      break;

    case 'Pesto Pasta':
      ingredients = [
        "200g pasta",
        "1/4 cup basil pesto",
        "2 tbsp olive oil",
        "1 clove garlic, minced",
        "1/4 cup grated Parmesan",
        "Salt and pepper to taste",
      ];
      break;

    case 'Greek Yogurt Parfait':
      ingredients = [
        "1 cup Greek yogurt",
        "1/2 cup granola",
        "1/4 cup mixed berries",
        "1 tbsp honey",
        "1 tsp chia seeds",
      ];
      break;

    case 'Quinoa Salad':
      ingredients = [
        "1 cup cooked quinoa",
        "1/2 cup diced cucumber",
        "1/2 cup diced tomato",
        "1/4 cup feta cheese",
        "2 tbsp olive oil",
        "1 tbsp lemon juice",
        "Salt and pepper to taste",
      ];
      break;

    case 'Protein Smoothie':
      ingredients = [
        "1 scoop protein powder",
        "1 cup almond milk",
        "1 banana",
        "1 tbsp peanut butter",
        "1/2 cup ice",
      ];
      break;

    case 'Keto Salad':
      ingredients = [
        "2 cups mixed greens",
        "1/2 avocado, sliced",
        "1/4 cup cherry tomatoes",
        "2 tbsp olive oil",
        "1 tbsp lemon juice",
        "Salt and pepper to taste",
      ];
      break;

    case 'Avocado Toast':
      ingredients = [
        "2 slices whole grain bread",
        "1/2 avocado, mashed",
        "1 tbsp olive oil",
        "Salt and pepper to taste",
        "1/4 tsp red pepper flakes (optional)",
      ];
      break;

    case 'Chicken Caesar Salad':
      ingredients = [
        "2 cups romaine lettuce",
        "1 grilled chicken breast, sliced",
        "1/4 cup Caesar dressing",
        "1/4 cup croutons",
        "2 tbsp Parmesan cheese",
      ];
      break;

    case 'Grilled Salmon':
      ingredients = [
        "2 salmon fillets",
        "1 tbsp olive oil",
        "1 lemon, sliced",
        "1 clove garlic, minced",
        "Salt and pepper to taste",
      ];
      break;

    case 'Vegan Buddha Bowl':
      ingredients = [
        "1 cup cooked brown rice",
        "1/2 cup chickpeas",
        "1/4 cup shredded carrots",
        "1/4 cup sliced avocado",
        "2 tbsp tahini dressing",
      ];
      break;

    case 'Turkey Wrap':
      ingredients = [
        "1 whole wheat tortilla",
        "2 slices turkey breast",
        "1 slice Swiss cheese",
        "1/4 cup mixed greens",
        "1 tbsp mustard",
      ];
      break;

    case 'Chicken Stir Fry':
      ingredients = [
        "1 chicken breast, diced",
        "1/2 cup bell peppers, sliced",
        "1/2 cup broccoli florets",
        "2 tbsp soy sauce",
        "1 tbsp sesame oil",
        "1 clove garlic, minced",
      ];
      break;

    default:
      ingredients = ["Ingredients not available."];
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: ingredients.map((ingredient) => Text('- $ingredient')).toList(),
  );
}

// Helper widget to build the instructions list based on meal name
Widget _buildInstructions(String name) {
  List<String> instructions = [];

  switch (name) {
    case 'Fruit Granola':
      instructions = [
        "Mix oats and yogurt in a bowl.",
        "Add honey and stir well.",
        "Top with almonds and berries.",
        "Serve and enjoy your healthy meal!"
    ];
      break;
      
    case 'Pesto Pasta':
      instructions = [
        "Cook pasta according to package instructions.",
        "Heat olive oil in a pan, add garlic and sauté for 1-2 minutes.",
        "Stir in basil pesto and cooked pasta, tossing to combine.",
        "Sprinkle with Parmesan cheese and season with salt and pepper.",
        "Serve hot and enjoy!"
      ];
      break;

    case 'Greek Yogurt Parfait':
      instructions = [
        "Layer Greek yogurt at the bottom of a glass.",
        "Top with granola and mixed berries.",
        "Drizzle with honey and sprinkle chia seeds.",
        "Serve immediately or refrigerate for later."
      ];
      break;

    case 'Quinoa Salad':
      instructions = [
        "In a large bowl, combine cooked quinoa, cucumber, tomato, and feta cheese.",
        "Drizzle with olive oil and lemon juice.",
        "Season with salt and pepper.",
        "Toss well and serve chilled."
      ];
      break;

    case 'Protein Smoothie':
      instructions = [
        "Add protein powder, almond milk, banana, peanut butter, and ice to a blender.",
        "Blend until smooth and creamy.",
        "Pour into a glass and enjoy your protein-packed smoothie!"
      ];
      break;

    case 'Keto Salad':
      instructions = [
        "In a bowl, combine mixed greens, avocado slices, and cherry tomatoes.",
        "Drizzle with olive oil and lemon juice.",
        "Season with salt and pepper.",
        "Toss lightly and serve immediately."
      ];
      break;

    case 'Avocado Toast':
      instructions = [
        "Toast the bread slices until golden brown.",
        "Spread mashed avocado on each slice.",
        "Drizzle with olive oil and sprinkle with salt, pepper, and red pepper flakes.",
        "Serve immediately."
      ];
      break;

    case 'Chicken Caesar Salad':
      instructions = [
        "In a large bowl, toss romaine lettuce with Caesar dressing.",
        "Top with sliced grilled chicken, croutons, and Parmesan cheese.",
        "Serve immediately."
      ];
      break;

    case 'Grilled Salmon':
      instructions = [
        "Preheat grill to medium heat.",
        "Brush salmon fillets with olive oil and season with garlic, salt, and pepper.",
        "Grill salmon for 6-8 minutes on each side.",
        "Serve with lemon slices and enjoy."
      ];
      break;

    case 'Vegan Buddha Bowl':
      instructions = [
        "Layer brown rice at the bottom of a bowl.",
        "Top with chickpeas, shredded carrots, and avocado slices.",
        "Drizzle with tahini dressing.",
        "Serve immediately."
      ];
      break;

    case 'Turkey Wrap':
      instructions = [
        "Place turkey breast slices and Swiss cheese on a whole wheat tortilla.",
        "Add mixed greens and drizzle with mustard.",
        "Roll up the tortilla tightly and slice in half.",
        "Serve chilled or at room temperature."
      ];
      break;

    case 'Chicken Stir Fry':
      instructions = [
        "Heat sesame oil in a pan, add garlic, and sauté for 1 minute.",
        "Add chicken and stir fry until fully cooked.",
        "Add bell peppers and broccoli, stir fry for 3-4 minutes.",
        "Stir in soy sauce and cook for another minute.",
        "Serve hot over rice or noodles."
      ];
      break;

    default:
      instructions = ["Instructions not available."];
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: instructions
        .asMap()
        .entries
        .map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('${entry.key + 1}. ${entry.value}'),
            ))
        .toList(),
  );
}