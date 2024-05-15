import 'package:project_flutter/model/user.dart';

class Order {
  final int id;
  final User user;
  final double priceTotal;

  Order({
    required this.id,
    required this.user,
    required this.priceTotal,
  });

  factory Order.fromSqlDatabase(Map<String, dynamic> map) => Order(
    id: map['id']?.ToInt() ?? 0,
    user: map['user'] ?? User(id: 0, name: 'n/a'),
    priceTotal: map['priceTotal']?.ToDouble() ?? 0,
  );
}