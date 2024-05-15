import 'package:sqflite/sqflite.dart';
import 'package:project_flutter/database/database_service.dart';
import 'package:project_flutter/model/user.dart';

class DB {
  final tableName = 'user';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
     "id" INTEGER NOT NULL,
     "name" VARCHAR NOT NULL,
     PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create({required String name}) async {
    final database = await DatabaseService().database;

    return await database.rawInsert(
      '''INSERT INTO $tableName (name) VALUES (?)''',
      [name],
    );
  }

  Future<int> update({required int id, String? name}) async {
    final database = await DatabaseService().database;

    return await database.update(
      tableName,
      {
        if(name != null) 'name': name,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  Future<List<User>> fetchAll() async {
    final database = await DatabaseService().database;
    final users = await database.rawQuery(
      '''SELECT * from $tableName'''
    );

    return users.map((user) => User.fromSqlDatabase(user)).toList();
  }

  Future<User> fetchById(int id) async {
    final database = await DatabaseService().database;
    final user = await database.rawQuery('''SELECT * from $tableName WHERE id = ?''', [id]);

    return User.fromSqlDatabase(user.first);
  }
}