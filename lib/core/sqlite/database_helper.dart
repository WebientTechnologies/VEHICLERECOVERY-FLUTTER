import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vinayak/core/sqlite/vehicledb.dart';

class DatabaseHelper {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await _initialize();
    create(_db!, 1);
    return _db!;
  }

  Future<String> get fullPath async {
    const name = "vinayak.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
        // await db
        //     .execute('PRAGMA main.cache_size = 20000'); // Increase cache size
        await db.execute('PRAGMA page_size = 32768');
      },
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    //print('db created');
    await VehicleDb.createTable(database);
  }
}
