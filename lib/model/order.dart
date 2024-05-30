
class Order {
  final int id;
  final String priceTotal;

  Order({
    required this.id,
    required this.priceTotal,
  });

  factory Order.fromSqlDatabase(Map<String, dynamic> map) => Order(
    id: map['id']?.ToInt() ?? 0,
    priceTotal: map['priceTotal']?.ToString() ?? '0',
  );
}