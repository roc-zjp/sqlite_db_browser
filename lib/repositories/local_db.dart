// ignore_for_file: avoid_print

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_db_browser/repositories/column_info.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';
import 'package:logger/logger.dart';

class LocalDb {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Database? _database;

  LocalDb._();

  Database get db => _database!;

  static LocalDb instance = LocalDb._();

  late String _databasePath = "";

  Future<void> initDb(String databasePath) async {
    if (_databasePath == databasePath && _database != null) return;
    _databasePath = databasePath;
    _database = await databaseFactoryFfi.openDatabase(databasePath);
    print('初始化数据库....');
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }

  Future<List<TableBean>> queryAllTables() async {
    List<Map<String, Object?>> results = await db
        .query("sqlite_master", where: 'type = ?', whereArgs: ['table']);
    List<TableBean> tables = List.empty(growable: true);

    for (var element in results) {
      print(element.toString());
      tables.add(TableBean(element['name'].toString()));
    }
    return tables;
  }

  Future<List<ColumnInfo>> queryAllColumn(TableBean table) async {
    List<Map<String, Object?>> results =
        await db.rawQuery("PRAGMA table_info ([${table.tableName}])");
    List<ColumnInfo> columns = List.empty(growable: true);

    for (var element in results) {
      logger.d(element);
      int pk = element['pk'] as int;
      if (pk == 1) {
        table.primaryKey = element['name'].toString();
      }
      columns.add(ColumnInfo(
          element['name'].toString(), element['type'].toString(),
          defaultValue: element['dflt_value'].toString()));
    }
    return columns;
  }

  Future<List<Map<String, Object?>>> queryAll(String tableName) async {
    List<Map<String, Object?>> results = await db.query(tableName);

    for (var element in results) {
      logger.d(element);
    }
    return results;
  }

  Future<List<Map<String, Object?>>> deleteAll(String tableName) async {
    List<Map<String, Object?>> results = await db.query(tableName);

    for (var element in results) {
      logger.d(element);
    }
    return results;
  }
}
