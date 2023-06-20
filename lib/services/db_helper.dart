import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:usermanagement/models/user.dart';

import '../models/notification.dart';

class UserDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Usermanagement.db";

  static Future<Database> _getDB() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, _dbName);

    // bool isDbExists = await databaseExists(dbPath);
    //
    // // if (isDbExists) {
    // //   await deleteDatabase(dbPath);
    // // }

    return openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstname TEXT,
          lastname TEXT,
          age INTEGER
        )
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS notification(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          username TEXT,
          message TEXT,
          hour INTEGER,
          minute INTEGER
        )
      ''');

      },
      version: _version,
    );
  }

//==============================================User Table===========================================================
  static Future<int> createUser(User user) async {
    final db = await _getDB();
    return await db.insert("user", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(User user) async {
    final db = await _getDB();
    return await db.update("user", user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteUser(User user) async {
    final db = await _getDB();
    return await db.delete("user", where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<int?> getUserIdByUsername(String username) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('user',
        columns: ['id'],
        where: 'lastname = ?',
        whereArgs: [username],
        limit: 1);

    if (maps.isNotEmpty) {
      return maps[0]['id'] as int?;
    } else {
      return null;
    }
  }

  static Future<List<User>?> getAllUsers() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("user");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }







//==============================================Notification Table===========================================================





  static Future<int> createNotification(MyNotification notification) async {
    final db = await _getDB();
    return await db.insert("notification", notification.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<MyNotification>?> getAllNotifications() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("notification");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => MyNotification.fromJson(maps[index]));
  }





}
