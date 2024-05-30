import 'package:flutter/material.dart';
import 'package:project_flutter/model/order_line.dart';

import '../database/database_service.dart';
import '../model/pizza_type.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<OrderLine> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final dbService = DatabaseService.instance;
    final loadedCartItems = await dbService.getOrderLines(0);

    for (OrderLine orderLine in loadedCartItems) {
      orderLine.pizzaType = await dbService.getPizza(orderLine.pizzaTypeId) ?? PizzaType(id: 0,
          name: 'Pizza',
          description: '',
          price: '0',
          image: '');
    }

    setState(() {
      cartItems = loadedCartItems;
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
      DatabaseService.instance.updateOrderLineQuantity(cartItems[index].id, cartItems[index].quantity);
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        DatabaseService.instance.updateOrderLineQuantity(cartItems[index].id, cartItems[index].quantity);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      DatabaseService.instance.deleteOrderLine(cartItems[index].id);
      cartItems.removeAt(index);
    });
  }

  void _clearCart() {
    setState(() {
      cartItems.clear();
      DatabaseService.instance.clearTable('orders_line');
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalQuantity = cartItems.fold(0, (sum, item) => sum + item.quantity);
    double totalPrice = cartItems.fold(0, (sum, item) => sum + (double.parse(item.pizzaType.price) * item.quantity));

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Panier',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                        ),
                        onPressed: _clearCart,
                        child: const Text(
                          'Vider panier',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cartItems[index].pizzaType.name),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () => _decrementQuantity(index),
                                    ),
                                    Text('${cartItems[index].quantity}'),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => _incrementQuantity(index),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red, // Background color
                                  ),
                                  onPressed: () => _removeItem(index),
                                  child: const Text(
                                    'Supprimer',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'x${totalQuantity.round()} pizzas',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '$totalPrice €',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        fixedSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Retour',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        // Action de commande
                      },
                      child: const Text(
                        'COMMANDER',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
