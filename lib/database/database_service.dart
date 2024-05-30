import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/order_line.dart';
import '../model/pizza_type.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('pizza_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      price_total REAL NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE orders_line (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      orders_id INTEGER NOT NULL,
      pizza_type_id INTEGER NOT NULL,
      quantity INTEGER NOT NULL,
      FOREIGN KEY (orders_id) REFERENCES orders (id),
      FOREIGN KEY (pizza_type_id) REFERENCES pizza_type (id)
    )
    ''');

    await db.execute('''
    CREATE TABLE pizza_type (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT,
      price REAL NOT NULL,
      image TEXT
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> insertPizza(Map<String, dynamic> pizza) async {
    final db = await DatabaseService.instance.database;

    await db.insert(
      'pizza_type',
      pizza,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<PizzaType?> getPizza(int pizzaId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'pizza_type',
      where: 'id = ?',
      whereArgs: [pizzaId],
    );

    if (result.isNotEmpty) {
      return PizzaType.fromSqlDatabase(result.first);
    } else {
      return null;
    }
  }

  Future<List<PizzaType>> getPizzas() async {
    final db = await DatabaseService.instance.database;
    List<Map<String, dynamic>> pizzas = await db.query('pizza_type');
    List<PizzaType> pizzaTypes = [];

    for (Map<String, dynamic> pizzaMap in pizzas) {
      pizzaTypes.add(PizzaType.fromSqlDatabase(pizzaMap));
    }

    return pizzaTypes;
  }

  Future<void> insertOrderLine(int orderId, int pizzaTypeId, int quantity) async {
    final db = await DatabaseService.instance.database;

    await db.insert(
      'orders_line',
      {
        'orders_id': orderId,
        'pizza_type_id': pizzaTypeId,
        'quantity': quantity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OrderLine>> getOrderLines(int orderId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'orders_line',
      where: 'orders_id = ?',
      whereArgs: [orderId],
    );

    List<OrderLine> orderLines = result.map((map) => OrderLine.fromSqlDatabase(map)).toList();
    return orderLines;
  }

  Future<void> deleteOrderLine(int orderLineId) async {
    final db = await instance.database;
    await db.delete(
      'orders_line',
      where: 'id = ?',
      whereArgs: [orderLineId],
    );
  }

  Future<void> updateOrderLineQuantity(int orderLineId, int newQuantity) async {
    final db = await instance.database;
    await db.update(
      'orders_line',
      {'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [orderLineId],
    );
  }

  Future<void> clearTable(String tableName) async {
    final db = await instance.database;
    await db.delete(tableName);
  }
}