class PizzaType {
  final int id;
  final String name;
  final String description;
  final double price;

  PizzaType({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory PizzaType.fromSqlDatabase(Map<String, dynamic> map) => PizzaType(
    id: map['id']?.ToInt() ?? 0,
    name: map['name'] ?? '',
    description: map['description'] ?? '',
    price: map['price']?.ToDouble() ?? 0,
  );
}