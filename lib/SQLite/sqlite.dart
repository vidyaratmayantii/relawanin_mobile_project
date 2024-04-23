import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:relawanin_mobile_project/JsonModels/relawan.dart';

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
  var result = await db.rawQuery("SELECT * from relawans where username = '${usr.username}' AND usrPass = '${usr.usrPass}'");
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

}
