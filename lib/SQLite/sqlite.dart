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
    String path = join(databasesPath, 'relawanin.db');

    var theDb = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE UserProfile(
      id INTEGER PRIMARY KEY,
      profilePic TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE FavoriteActivities(
      id INTEGER PRIMARY KEY,
      namaKegiatan TEXT,
      lokasi TEXT,
      deskripsiKegiatan TEXT,
      aktivitasKegiatan TEXT,
      ketentuanKegiatan TEXT,
      tanggalKegiatan TEXT,
      batasRegistrasi TEXT,
      estimasiPoint INTEGER,
      imageUrl TEXT
    )
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db
          .execute('ALTER TABLE FavoriteActivities ADD COLUMN imageUrl TEXT');
    }
  }

  Future<int> saveProfilePic(String path) async {
    var dbClient = await db;
    await dbClient!.delete('UserProfile');
    return await dbClient.insert('UserProfile', {'profilePic': path});
  }

  Future<String?> getProfilePic() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT profilePic FROM UserProfile LIMIT 1');
    if (list.isNotEmpty) {
      return list[0]['profilePic'];
    }
    return null;
  }

  Future<int> insertFavoriteActivity(Map<String, dynamic> activityData) async {
    var dbClient = await db;
    return await dbClient!.insert('FavoriteActivities', activityData);
  }

  Future<int> deleteFavoriteActivity(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete('FavoriteActivities', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map>> getFavoriteActivities() async {
    var dbClient = await db;
    return await dbClient!.query('FavoriteActivities');
  }
}
