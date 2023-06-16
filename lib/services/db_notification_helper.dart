import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/notification.dart';

class NotificationDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notificationmanagement.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS notification(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
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

  static Future<void> closeDatabase() async {
    final db = await _getDB();
    await db.close();
  }
}
