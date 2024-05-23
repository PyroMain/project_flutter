import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pizza_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> pizzas = [
    {'name': 'Pizza 1', 'image': 'assets/35-pizza-png-image.png', 'price': '10€', 'description': 'Delicious cheesy pizza with a balance of spice.'},
    {'name': 'Pizza 2', 'image': 'assets/35-pizza-png-image.png', 'price': '12€', 'description': 'Spicy pizza with extra cheese.'},
    {'name': 'Pizza 3', 'image': 'assets/35-pizza-png-image.png', 'price': '11€', 'description': 'Vegetarian pizza with fresh vegetables.'},
    {'name': 'Pizza 4', 'image': 'assets/35-pizza-png-image.png', 'price': '9€', 'description': 'Classic Margherita pizza with a tangy tomato base.'},
    {'name': 'Pizza 5', 'image': 'assets/35-pizza-png-image.png', 'price': '13€', 'description': 'Four cheese pizza with a rich blend of flavors.'},
    {'name': 'Pizza 6', 'image': 'assets/35-pizza-png-image.png', 'price': '10€', 'description': 'Pepperoni pizza with a crispy crust.'},
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredPizzas = pizzas.where((pizza) {
      return pizza['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Image.asset('assets/35-pizza-png-image.png', scale: 14),
            const SizedBox(width: 8),
            const Text(
              'PIZZA',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.arrow_right_to_line)),
        ],
      ),
      body: Column(
        children: [
          SearchBar(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),
          Expanded(
            child: PizzaGrid(filteredPizzas: filteredPizzas),
          ),
        ],
      ),
    );
  }
}
