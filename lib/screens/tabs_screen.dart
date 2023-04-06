import 'package:flutter/material.dart';

import '../models/meal.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPage = 0;

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'DeliMeals'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorites'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPage]['title'],
        ),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}

// upper tabbar
// return DefaultTabController(
//       length: 2,
//       initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "DeliMeals",
//           ),
//           bottom: TabBar(
//             tabs: const [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: "Categories",
//               ),
//               Tab(
//                 icon: Icon(Icons.star),
//                 text: "Favorites",
//               ),
//             ],
//             // labelColor: Theme.of(context).colorScheme.secondary,
//             indicatorColor: Theme.of(context).colorScheme.secondary,
//             unselectedLabelColor: Theme.of(context).colorScheme.secondary,
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             CategoriesScreen(),
//             const FavoritesScreen(),
//           ],
//         ),
//       ),
//     );
