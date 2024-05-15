import 'package:project_flutter/model/order.dart';
import 'package:project_flutter/model/pizza_type.dart';
import 'package:project_flutter/model/user.dart';

class OrderLine {
  final int id;
  final Order order;
  final PizzaType pizzaType;
  final int quantity;

  OrderLine({
    required this.id,
    required this.order,
    required this.pizzaType,
    required this.quantity,
  });

  factory OrderLine.fromSqlDatabase(Map<String, dynamic> map) => OrderLine(
    id: map['id']?.ToInt() ?? 0,
    order: map['order'] ?? Order(id: 0, user: User(id: 0, name: 'n/a'), priceTotal: 0),
    pizzaType: map['pizzaType'] ?? PizzaType(id: 0, name: 'n/a', description: '', price: 0),
    quantity: map['quantity'] ?? 0,
  );
}