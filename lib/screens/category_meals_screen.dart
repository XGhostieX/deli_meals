import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals, {super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String title;
  late List<Meal> categoryMeals;
  bool _intData = false;

  @override
  void didChangeDependencies() {
    if (!_intData) {
      final routesArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final String id = routesArgs['id'] as String;
      title = routesArgs['title'] as String;
      categoryMeals = widget.availableMeals
          .where((element) => element.categories.contains(id))
          .toList();
      _intData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeal(String id) {
  //   setState(() {
  //     categoryMeals.removeWhere((element) => element.id == id);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            categoryMeals[index].id,
            categoryMeals[index].title,
            categoryMeals[index].imageUrl,
            categoryMeals[index].duration,
            categoryMeals[index].complexity,
            categoryMeals[index].affordability,
          );
        }),
        itemCount: categoryMeals.length,
      ),
    );
  }
}
