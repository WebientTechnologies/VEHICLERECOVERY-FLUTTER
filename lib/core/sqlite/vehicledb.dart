import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:vinayak/core/sqlite/models/vehicle_model.dart';

import 'database_helper.dart';

class VehicleDb {
  String tableName = "vehicles";

  static Future<void> createTable(Database database) async {
    await database.execute('''
        CREATE TABLE IF NOT EXISTS vehicles(
          "id" integer null,
          "dataId" text null,
          "loadStatus" text null,
          "bankName" text null,
          "branch" text null,
          "agreementNo" text null,
          "customerName" text null,
          "regNo" text UNIQUE null,
          "chasisNo" text null,
          "engineNo" text null,
          "callCenterNo1" text null,
          "callCenterNo1Name" text null,
          "callCenterNo2" text null,
          "callCenterNo2Name" text null,
          "lastDigit" text null,
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
    loadStatus,
    bankName,
    branch,
    agreementNo,
    customerName,
    regNo,
    chasisNo,
    engineNo,
    callCenterNo1,
    callCenterNo1Name,
    callCenterNo2,
    callCenterNo2Name,
    lastDigit,
    month,
    status,
    fileName,
    createdAt,
    updatedAt,
  ) async {
    final db = await DatabaseHelper().database;
    int id = await db.rawInsert('''
      INSERT OR REPLACE INTO $tableName (dataId,loadStatus,bankName,branch,agreementNo,customerName,regNo,chasisNo,engineNo,callCenterNo1,callCenterNo1Name,callCenterNo2,callCenterNo2Name,lastDigit,month,status,fileName,createdAt,updatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
      ''', [
      dataId,
      loadStatus,
      bankName,
      branch,
      agreementNo,
      customerName,
      regNo,
      chasisNo,
      engineNo,
      callCenterNo1,
      callCenterNo1Name,
      callCenterNo2,
      callCenterNo2Name,
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

  Future<int> updateFile(int id, String projectid, String name, String path,
      int ischecked, int folderid, Uint8List file, Uint8List rawFile) async {
    final db = await DatabaseHelper().database;
    return await db.update(
        tableName,
        {
          'project_id': projectid,
          'name': name,
          'path': path,
          'ischecked': ischecked,
          'folderid': folderid,
          'file': file,
          'raw_file': rawFile
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<int> updateFileCheckUncheck(int id, int ischecked) async {
    final db = await DatabaseHelper().database;
    return await db.update(
        tableName,
        {
          'ischecked': ischecked,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<int> updateFileStatus(int id, int status) async {
    final db = await DatabaseHelper().database;
    return await db.update(
        tableName,
        {
          'upload_status': status,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final db = await DatabaseHelper().database;
    await db.rawDelete('''
      DELETE FROM $tableName WHERE id = ?
    ''', [id]);
  }

  Future<void> deleteByFolder(int parentId) async {
    final db = await DatabaseHelper().database;
    await db.rawDelete('''
      DELETE FROM $tableName WHERE folderid = ?
    ''', [parentId]);
  }

  Future<void> dropFile() async {
    final db = await DatabaseHelper().database;
    await db.rawQuery('''
      DROP TABLE $tableName
    ''');
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
    select * from $tableName where lastDigit LIKE ?
    ''', ['%$lastDigit%']);
    print(files);
    return files.map((e) => VehicleModel.fromSqfliteDatabase(e)).toList();
  }

  // Future<List<FileModel>> fetchByFileId(int fileid) async {
  //   final db = await DatabaseHelper().database;
  //   final files = await db.rawQuery('''
  //   select * from $tableName where id = ?
  //   ''', [fileid]);
  //   return files.map((e) => FileModel.fromSqfliteDatabase(e)).toList();
  // }

  Future<int> getCountByProjectID(String projectid) async {
    final db = await DatabaseHelper().database;
    final count = await db.rawQuery('''
    select count(id) from $tableName where project_id = ?
    ''', [projectid]);
    int c = Sqflite.firstIntValue(count) ?? 0;
    return c;
  }

  Future<int> getSelectedCountByProjectID(String projectid) async {
    final db = await DatabaseHelper().database;
    final count = await db.rawQuery('''
    select count(id) from $tableName where project_id = ? and ischecked = 1
    ''', [projectid]);
    int c = Sqflite.firstIntValue(count) ?? 0;
    return c;
  }
}
