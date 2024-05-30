class PizzaType {
  final int id;
  final String name;
  final String description;
  final String price;
  final String image;

  PizzaType({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory PizzaType.fromSqlDatabase(Map<String, dynamic> map) => PizzaType(
    id: map['id']?.toInt() ?? '0',
    name: map['name'] ?? '',
    description: map['description'] ?? '',
    price: map['price']?.toString() ?? '0',
    image: map['image'] ?? '',
  );
}