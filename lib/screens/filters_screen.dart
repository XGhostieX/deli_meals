import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> currentFilters;
  final Function saveFilters;

  const FiltersScreen(this.currentFilters, this.saveFilters, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filters",
        ),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Adjust Meal Selection",
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  value: _glutenFree,
                  onChanged: (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                  title: const Text(
                    "Gluten-Free",
                  ),
                  subtitle: const Text(
                    "Only Include Gluten-Free Meals",
                  ),
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
                SwitchListTile(
                  value: _lactoseFree,
                  onChanged: (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                  title: const Text(
                    "Lactose-Free",
                  ),
                  subtitle: const Text(
                    "Only Include Lactose-Free Meals",
                  ),
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
                SwitchListTile(
                  value: _vegan,
                  onChanged: (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                  title: const Text(
                    "Vegan",
                  ),
                  subtitle: const Text(
                    "Only Include Vegan Meals",
                  ),
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
                SwitchListTile(
                  value: _vegetarian,
                  onChanged: (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                  title: const Text(
                    "Vegetarian",
                  ),
                  subtitle: const Text(
                    "Only Include Vegetarian Meals",
                  ),
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
