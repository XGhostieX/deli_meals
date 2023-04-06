import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetailScreen(this.toggleFavorite, this.isFavorite, {super.key});

  Widget buildTitle(BuildContext context, title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildContainer(child) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final meal = meals.firstWhere((meal) => meal.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildTitle(
              context,
              "Ingredients",
            ),
            buildContainer(
              ListView.builder(
                itemBuilder: ((context, index) => Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          meal.ingredients[index],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
                itemCount: meal.ingredients.length,
              ),
            ),
            buildTitle(
              context,
              "Steps",
            ),
            buildContainer(ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text("${(index + 1)}"),
                    ),
                    title: Text(meal.steps[index]),
                  ),
                  const Divider(),
                ],
              ),
              itemCount: meal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(id) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(id),
      ),
    );
  }
}
