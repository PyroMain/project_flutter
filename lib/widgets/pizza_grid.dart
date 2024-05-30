import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/database/database_service.dart';

import '../model/pizza_type.dart';

class PizzaGrid extends StatelessWidget {
  final List<PizzaType> filteredPizzas;

  const PizzaGrid({required this.filteredPizzas, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: filteredPizzas.length,
        itemBuilder: (context, int i) {
          return Material(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  filteredPizzas[i].image,
                  fit: BoxFit.cover,
                  height: 125,
                  width: double.infinity,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    filteredPizzas[i].name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    filteredPizzas[i].description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${filteredPizzas[i].price} €',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.info_circle),
                            iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () {
                              DatabaseService.instance.insertOrderLine(0, filteredPizzas[i].id, 1);
                            },
                            icon: const Icon(CupertinoIcons.add_circled_solid),
                            iconSize: 30,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
