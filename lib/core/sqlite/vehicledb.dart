import 'package:sqflite/sqflite.dart';
import 'package:vinayak/core/sqlite/models/vehicle_model.dart';

import 'database_helper.dart';

class VehicleDb {
  String tableName = "vehicles";

  static Future<void> createTable(Database database) async {
    await database.execute('''
        CREATE TABLE IF NOT EXISTS vehicles(
          "id" INTEGER PRIMARY KEY AUTOINCREMENT,
          "dataId" text null,
          "bankName" text null,
          "branch" text null,
          "regNo" text null,
          "loanNo" text null,
          "customerName" text null,
          "model" text null,
          "maker" text null,
          "chasisNo" text null,
          "engineNo" text null,
          "emi" text null,
          "bucket" text null,
          "pos" text null,
          "tos" text null,
          "allocation" text null,
          "callCenterNo1" text null,
          "callCenterNo1Name" text null,
          "callCenterNo1Email" text null,
          "callCenterNo2" text null,
          "callCenterNo2Name" text null,
          "callCenterNo2Email" text null,
          "callCenterNo3" text null,
          "callCenterNo3Name" text null,
          "callCenterNo3Email" text null,
          "address" text null,
          "sec17" text null,
          "agreementNo" text null,
          "dlCode" text null,
          "color" text null,
          "lastDigit" text null,
          "loadStatus" text null,
          "month" text null,
          "status" text null,
          "fileName" text null,
          "createdAt" text null,
          "updatedAt" text null,
          primary key("id" AUTOINCREMENT)
          )
      ''');
  }

  Future<int> insertVehicle(
    String dataId,
    bankName,
    branch,
    regNo,
    loanNo,
    customerName,
    model,
    maker,
    chasisNo,
    engineNo,
    emi,
    bucket,
    pos,
    tos,
    allocation,
    callCenterNo1,
    callCenterNo1Name,
    callCenterNo1Email,
    callCenterNo2,
    callCenterNo2Name,
    callCenterNo2Email,
    callCenterNo3,
    callCenterNo3Name,
    callCenterNo3Email,
    address,
    sec17,
    agreementNo,
    dlCode,
    color,
    lastDigit,
    month,
    status,
    fileName,
    createdAt,
    updatedAt,
  ) async {
    final db = await DatabaseHelper().database;
    int id = await db.rawInsert('''
      INSERT INTO $tableName (
      dataId,
      bankName,
    branch,
    regNo,
    loanNo,
    customerName,
    model,
    maker,
    chasisNo,
    engineNo,
    emi,bucket,pos,tos,allocation,
    callCenterNo1,
    callCenterNo1Name,
    callCenterNo1Email,
    callCenterNo2,
    callCenterNo2Name,
    callCenterNo2Email,
    callCenterNo3,
    callCenterNo3Name,
    callCenterNo3Email,
    address,
    sec17,
    agreementNo,dlCode,color,
    lastDigit,
    month,
    status,
    fileName,
    createdAt,
    updatedAt,) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
      ''', [
      dataId,
      bankName,
      branch,
      regNo,
      loanNo,
      customerName,
      model,
      maker,
      chasisNo,
      engineNo,
      emi,
      bucket,
      pos,
      tos,
      allocation,
      callCenterNo1,
      callCenterNo1Name,
      callCenterNo1Email,
      callCenterNo2,
      callCenterNo2Name,
      callCenterNo2Email,
      callCenterNo3,
      callCenterNo3Name,
      callCenterNo3Email,
      address,
      sec17,
      agreementNo,
      dlCode,
      color,
      lastDigit,
      month,
      status,
      fileName,
      createdAt,
      updatedAt,
    ]);
    print('vehicle created');
    return id;
  }

  Future<void> delete(int id) async {
    final db = await DatabaseHelper().database;
    await db.rawDelete('''
      DELETE FROM $tableName WHERE id = ?
    ''', [id]);
  }

  Future<String> getLastId() async {
    final db = await DatabaseHelper().database;
    final id = await db.rawQuery('''
    select dataId from $tableName order by id desc limit 1
    ''');
    print(id[0]['dataId']);
    return id[0]['dataId'].toString();
  }

  Future<List<VehicleModel>> fetchAll() async {
    final db = await DatabaseHelper().database;
    final files = await db.rawQuery('''
    select * from $tableName
    ''');
    print(files);
    return files.map((e) => VehicleModel.fromSqfliteDatabase(e)).toList();
  }

  Future<List<VehicleModel>> fetchByReg(String lastDigit) async {
    final db = await DatabaseHelper().database;
    final files = await db.rawQuery('''
    select * from $tableName where status IN (?,?) AND lastDigit = ? ORDER BY regNo ASC
    ''', ['search', 'pending', lastDigit]);
    //print(files);
    final List<VehicleModel> vehicles = files.map((Map<String, dynamic> row) {
      return VehicleModel.fromSqfliteDatabase(row);
    }).toList();

    return vehicles;
  }

  Future<List<VehicleModel>> fetchByChasis(String chasis) async {
    final db = await DatabaseHelper().database;
    final files = await db.rawQuery('''
    select * from $tableName where status IN (?,?) AND chasisNo = ? ORDER BY regNo ASC
    ''', ['search', 'pending', chasis]);
    //print(files);
    return files.map((e) => VehicleModel.fromSqfliteDatabase(e)).toList();
  }

  Future<int> getOfflineCount() async {
    final db = await DatabaseHelper().database;
    final count = await db.rawQuery('''
    select count(id) from $tableName
    ''');
    int c = Sqflite.firstIntValue(count) ?? 0;
    return c;
  }

  Future<void> createIndex() async {
    final db = await DatabaseHelper().database;
    await db
        .execute('CREATE INDEX idx_lastDigit ON vehicles (lastDigit)')
        .then((v) async {
      await db
          .execute('CREATE INDEX idx_chasisNo ON vehicles (chasisNo)')
          .then((v) {
        print('index created');
      });
    });
  }
}
