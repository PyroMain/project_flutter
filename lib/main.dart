import 'package:flutter/material.dart';
import 'package:project_flutter/views/cart.dart';
import 'package:project_flutter/views/home.dart';
import 'database/database_service.dart';
import 'database/userDB.dart';
import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      //home: const PizzaCartApp(),
      home: const HomeScreen(),
    );
  }
}