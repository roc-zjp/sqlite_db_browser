

import 'package:sqlite_db_browser/repositories/column_info.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    _database = await databaseFactory.openDatabase(databasePath);
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }

  Future<List<TableInfo>> queryAllTables() async {
    List<Map<String, Object?>> results = await db
        .query("sqlite_master", where: 'type = ?', whereArgs: ['table']);
    List<TableInfo> tables = List.empty(growable: true);

    for (var element in results) {
      logger.d(element.toString());
      String tableName = element['name'].toString();
      var info = await queryTableInfo(tableName);
      tables.add(info);
    }
    return tables;
  }

  Future<TableInfo> queryTableInfo(String tableName) async {
    List<Map<String, Object?>> results =
        await db.rawQuery("PRAGMA table_info ([$tableName])");
    List<ColumnInfo> columns = List.empty(growable: true);
    TableInfo info = TableInfo(tableName);

    for (var element in results) {
      logger.d(element);
      int pk = element['pk'] as int;
      if (pk == 1) {
        info.primaryKey = element['name'].toString();
      }
      columns.add(ColumnInfo(
          element['name'].toString(), element['type'].toString(),
          defaultValue: element['dflt_value'].toString()));
      info.columns = columns;
    }
    return info;
  }

  Future<List<Map<String, Object?>>> queryAll(String tableName) async {
    List<Map<String, Object?>> results = await db.query(tableName);
    // for (var element in results) {
    //   logger.d(element);
    // }
    return results;
  }

  Future<int> deleteAllByPrimaryKeys(
      String tableName, String primaryKey, List<Object?>? selecteds) async {
    var batch = db.batch();
    selecteds?.forEach((element) {
      batch.delete(tableName, where: '$primaryKey = ?', whereArgs: [element]);
    });
    var results = await batch.commit();
    return results.length;
  }

  Future<int> update(
      String tableName, Map<String, Object?> map, String primaryKey) async {
    int result = await db.update(tableName, map,
        where: '$primaryKey = ?', whereArgs: [map[primaryKey]]);
    logger.d("result=$result");
    return result;
  }

  Future<int> insert(String tableName, Map<String, Object?> map) async {
    int result = await db.insert(tableName, map);
    logger.d("result=$result");
    return result;
  }
}
