import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/model/pizza_type.dart';
import 'package:project_flutter/widgets/search_bar.dart';
import '../database/database_service.dart';
import '../widgets/pizza_grid.dart';
import 'cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PizzaType> pizzas = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    loadPizzas();
  }

  Future<void> loadPizzas() async {
    final dbService = DatabaseService.instance;
    final loadedPizzas = await dbService.getPizzas();

    setState(() {
      pizzas = loadedPizzas;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PizzaType> filteredPizzas = pizzas.where((pizza) {
      return pizza.name.toLowerCase().contains(query.toLowerCase());
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
