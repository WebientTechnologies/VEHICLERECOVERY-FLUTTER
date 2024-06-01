import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    print(appDocumentsDirectory.path);
    final path = appDocumentsDirectory.path;
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
      // onConfigure: (Database db) async {
      //   await db.execute('PRAGMA foreign_keys = ON');
      //   // await db
      //   //     .execute('PRAGMA main.cache_size = 20000'); // Increase cache size
      //   await db.execute('PRAGMA page_size = 32768');
      // },
    );
    // try {
    //   await database
    //       .execute('CREATE INDEX idx_lastDigit ON vehicles (lastDigit)');
    // } catch (e) {
    //   if (e is DatabaseException && e.toString().contains('already exists')) {
    //     // Index already exists, ignore the error
    //   } else {
    //     rethrow;
    //   }
    // }
    return database;
  }

  Future<void> create(Database database, int version) async {
    //print('db created');
    await VehicleDb.createTable(database);
  }
}
