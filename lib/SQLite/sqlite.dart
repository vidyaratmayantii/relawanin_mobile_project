import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'profile.db');

    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE UserProfile(
      id INTEGER PRIMARY KEY,
      profilePic TEXT
    )
    ''');
  }

  

  Future<int> saveProfilePic(String path) async {
    var dbClient = await db;
    await dbClient!.delete('UserProfile');
    return await dbClient.insert('UserProfile', {'profilePic': path});
  }

  Future<String?> getProfilePic() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT profilePic FROM UserProfile LIMIT 1');
    if (list.isNotEmpty) {
      return list[0]['profilePic'];
    }
    return null;
  }
}
// 