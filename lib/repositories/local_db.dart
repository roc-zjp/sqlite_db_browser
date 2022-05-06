// // ignore_for_file: avoid_print

// import 'dart:developer';

// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common/sqlite_api.dart' as sqlite_api;
// import 'package:sqlite_db_browser/repositories/column_info.dart';
// import 'package:sqlite_db_browser/repositories/table_baen.dart';
// import 'package:logger/logger.dart';

// class LocalDb {
//   var logger = Logger(
//     printer: PrettyPrinter(),
//   );

//   sqlite_api.Database? _database;

//   LocalDb._();

//   sqlite_api.Database get db => _database!;

//   static LocalDb instance = LocalDb._();

//   late String _databasePath = "";

//   Future<void> initDb(String databasePath) async {
//     if (_databasePath == databasePath && _database != null) return;
//     _databasePath = databasePath;
//     sqlite_api.OpenDatabaseOptions options = sqlite_api.OpenDatabaseOptions(
//         readOnly: false,
//         onOpen: (data) {
//           logger.d("on open");
//         });
//     _database =
//         await databaseFactoryFfi.openDatabase(databasePath, options: options);
//     print('初始化数据库....');
//   }

//   // sqlite_api.DatabaseFactory getDatabaseFactory() {
//   //   if (Platform.isWindows || Platform.isLinux) {
//   //     return databaseFactoryFfi;
//   //   } else {
//   //     return databaseFactoryFfi;
//   //   }
//   // }

//   Future<void> closeDb() async {
//     await _database?.close();
//     _database = null;
//   }

//   Future<List<TableBean>> queryAllTables() async {
//     List<Map<String, Object?>> results = await db
//         .query("sqlite_master", where: 'type = ?', whereArgs: ['table']);
//     List<TableBean> tables = List.empty(growable: true);

//     for (var element in results) {
//       print(element.toString());
//       tables.add(TableBean(element['name'].toString()));
//     }
//     return tables;
//   }

//   Future<List<ColumnInfo>> queryAllColumn(TableBean table) async {
//     List<Map<String, Object?>> results =
//         await db.rawQuery("PRAGMA table_info ([${table.tableName}])");
//     List<ColumnInfo> columns = List.empty(growable: true);

//     for (var element in results) {
//       logger.d(element);
//       int pk = element['pk'] as int;
//       if (pk == 1) {
//         table.primaryKey = element['name'].toString();
//       }
//       columns.add(ColumnInfo(
//           element['name'].toString(), element['type'].toString(),
//           defaultValue: element['dflt_value'].toString()));
//     }
//     return columns;
//   }

//   Future<List<Map<String, Object?>>> queryAll(String tableName) async {
//     List<Map<String, Object?>> results = await db.query(tableName);
//     for (var element in results) {
//       logger.d(element);
//     }
//     return results;
//   }

//   Future<List<Map<String, Object?>>> deleteAll(String tableName) async {
//     List<Map<String, Object?>> results = await db.query(tableName);
//     for (var element in results) {
//       logger.d(element);
//     }
//     return results;
//   }

//   Future<int> update(
//       String tableName, Map<String, Object?> map, String primaryKey) async {
//     if (db.isOpen) {
//       logger.d("数据库已打开");
//     }
//     var data = Map<String, Object>();
//     data['name'] = 'test';
//      data['nameCN'] = 'test';
//      data['deprecated'] = 0;

//      data['family'] = 0;
//      data['lever'] = 5.0;
//      data['linkWidget'] = 160;

//      data['info'] = 'test for test';

//     return db.insert(tableName, data);
//   }
// }

// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
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
    OpenDatabaseOptions options = OpenDatabaseOptions(
        readOnly: false,
        onOpen: (data) {
          logger.d("on open");
        });
    _database = await openDatabase(databasePath, readOnly: false);
    print('初始化数据库....');
  }

  // sqlite_api.DatabaseFactory getDatabaseFactory() {
  //   if (Platform.isWindows || Platform.isLinux) {
  //     return databaseFactoryFfi;
  //   } else {
  //     return databaseFactoryFfi;
  //   }
  // }

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
    // for (var element in results) {
    //   logger.d(element);
    // }
    return results;
  }

  Future<List<Map<String, Object?>>> deleteAll(String tableName) async {
    List<Map<String, Object?>> results = await db.query(tableName);
    // for (var element in results) {
    //   logger.d(element);
    // }
    return results;
  }

  Future<int> update(
      String tableName, Map<String, Object?> map, String primaryKey) async {
    int result = await db.update(tableName, map,
        where: '$primaryKey = ?', whereArgs: [map[primaryKey]]);
    logger.d("result=$result");
    return result;
  }
}
