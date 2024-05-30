import 'package:project_flutter/model/order.dart';
import 'package:project_flutter/model/pizza_type.dart';

class OrderLine {
  final int id;
  final Order order;
  final int pizzaTypeId;
  PizzaType pizzaType;
  int quantity;

  OrderLine({
    required this.id,
    required this.order,
    required this.pizzaTypeId,
    required this.pizzaType,
    required this.quantity,
  });

  factory OrderLine.fromSqlDatabase(Map<String, dynamic> map) {
    return OrderLine(
      id: map['id']?.toInt() ?? 0,
      order: map['order'] ?? Order(id: 0, priceTotal: '0'),
      pizzaTypeId: map['pizza_type_id'] ?? 0,
      pizzaType: PizzaType(id: 0,
          name: 'Pizza',
          description: '',
          price: '0',
          image: ''),
      quantity: map['quantity'] ?? 0,
    );
  }
}