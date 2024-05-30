import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/widgets/search_bar.dart';
import '../widgets/pizza_grid.dart';
import 'cart.dart';

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
    {'name': 'Pizza 7', 'image': 'assets/35-pizza-png-image.png', 'price': '9€', 'description': 'Classic Margherita pizza with a tangy tomato base.'},
    {'name': 'Pizza 8', 'image': 'assets/35-pizza-png-image.png', 'price': '13€', 'description': 'Four cheese pizza with a rich blend of flavors.'},
    {'name': 'Pizza 9', 'image': 'assets/35-pizza-png-image.png', 'price': '10€', 'description': 'Pepperoni pizza with a crispy crust.'},
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
            Image.asset('assets/pizza.png', scale: 20),
            const SizedBox(width: 8),
            const Text(
              'PIZZA',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              icon: const Icon(
                  CupertinoIcons.cart_fill,
                  color: Colors.white,
              )
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: PizzaGrid(filteredPizzas: filteredPizzas),
          ),
        ],
      ),
    );
  }
}
