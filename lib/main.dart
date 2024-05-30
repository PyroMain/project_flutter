import 'package:flutter/material.dart';
import 'package:project_flutter/views/home.dart';

import 'database/database_service.dart';

void main() async {
  // Tentative de clear de la table "pizza_type" avant le lancement de l'application pour ne pas avoir de doublons
  //WidgetsFlutterBinding.ensureInitialized();
  //await DatabaseService.instance.clearTable('pizza_type');
  runApp(const MyApp());

  insertSampleData();
}

Future<void> insertSampleData() async {
  final dbService = DatabaseService.instance;

  List<Map<String, dynamic>> samplePizzas = [
    {
      'name': 'Margherita',
      'description': 'Tomato, mozzarella, and fresh basil.',
      'price': 8.50,
      'image': 'assets/margherita.png',
    },
    {
      'name': 'Pepperoni',
      'description': 'Tomato, mozzarella, and pepperoni.',
      'price': 9.00,
      'image': 'assets/pepperoni.png',
    },
    {
      'name': 'Four Cheese',
      'description': 'Mozzarella, parmesan, gorgonzola, goat.',
      'price': 10.00,
      'image': 'assets/four_cheese.png',
    },
    {
      'name': 'Vegetarian',
      'description': 'Tomato, mozzarella, and mixed vegetables.',
      'price': 9.50,
      'image': 'assets/vegetarian.png',
    },
    {
      'name': 'Hawaiian',
      'description': 'Tomato, mozzarella, ham, and pineapple.',
      'price': 10.00,
      'image': 'assets/hawaiian.png',
    },
    {
      'name': 'BBQ Chicken',
      'description': 'BBQ sauce, mozzarella, and chicken.',
      'price': 11.00,
      'image': 'assets/bbq_chicken.png',
    },
    {
      'name': 'Meat Lovers',
      'description': 'Tomato, mozzarella, ham, bacon, and sausage.',
      'price': 12.00,
      'image': 'assets/meat_lovers.png',
    },
    {
      'name': 'Mexican',
      'description': 'Tomato, mozzarella, jalapenos, and beef.',
      'price': 10.50,
      'image': 'assets/mexican.png',
    },
    {
      'name': 'Seafood',
      'description': 'Tomato, mozzarella, shrimp, and calamari.',
      'price': 13.00,
      'image': 'assets/seafood.png',
    },
  ];

  for (var pizza in samplePizzas) {
    await dbService.insertPizza(pizza.map((key, value) => MapEntry(key, value as dynamic)));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}