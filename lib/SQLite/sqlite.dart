import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:relawanin_mobile_project/Models/relawan.dart';

class DatabaseHelper {
  final String databaseName = "RelawanIn.db";

  // Query untuk membuat tabel relawans
  final String relawanTableQuery = '''
    CREATE TABLE relawans (
      usrId INTEGER PRIMARY KEY AUTOINCREMENT,
      fullname TEXT,
      username TEXT UNIQUE,
      email TEXT,
      usrPass TEXT
    )
  ''';

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(relawanTableQuery);
    });
  }

  // Fungsi untuk melakukan login
  Future<bool> login(Relawan usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "SELECT * from relawans where username = '${usr.username}' AND usrPass = '${usr.usrPass}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // fungsi regis
  Future<int> signUp(Relawan usr) async {
    final Database db = await initDB();
    return db.insert('relawans', usr.toMap());
  }

  // Fungsi untuk mendapatkan data pengguna dari database
  Future<Relawan?> getUserData() async {
    final Database db = await initDB();
    List<Map<String, dynamic>> result = await db.query('relawans');
    if (result.isNotEmpty) {
      return Relawan.fromMap(result.first);
    } else {
      return null;
    }
  }

// Fungsi untuk memperbarui data pengguna dalam database
  Future<void> updateUserData(Relawan updatedUser) async {
    final Database db = await initDB();
    await db.update(
      'relawans',
      updatedUser.toMap(),
      where: 'usrId = ?',
      whereArgs: [updatedUser.usrId],
    );
  }
}
