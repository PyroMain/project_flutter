class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromSqlDatabase(Map<String, dynamic> map) => User(
    id: map['id']?.ToInt() ?? 0,
    name: map['name'] ?? '',
  );
}