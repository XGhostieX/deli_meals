import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';

void main() {
  runApp(const DeliMeals());
}

class DeliMeals extends StatefulWidget {
  const DeliMeals({super.key});

  @override
  State<DeliMeals> createState() => _DeliMealsState();
}

class _DeliMealsState extends State<DeliMeals> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = meals;
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = meals.where((element) {
        if (_filters['gluten'] == true && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !element.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String id) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == id);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          meals.firstWhere((element) => element.id == id),
        );
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        // primarySwatch: Color.fromRGBO(229, 33, 101, 1),
        // accentColor: Color.fromRGBO(13, 17, 55, 1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(229, 33, 101, 1),
          secondary: const Color.fromRGBO(13, 17, 55, 1),
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (_) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   if (settings.name == '/meal-detail') {
      //     return ...;
      //   } else if (settings.name == '/something-else') {
      //     return ...;
      //   }
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );
      },
    );
  }
}
