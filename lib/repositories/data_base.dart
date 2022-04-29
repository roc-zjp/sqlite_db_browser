// import 'package:flutter/foundation.dart';
// import 'package:sqlite3/sqlite3.dart';
// import 'package:sqlite_db_browser/repositories/column_info.dart';
// import 'package:sqlite_db_browser/repositories/table_baen.dart';

// class Db {
//   final String databasePath;
//   late Database db;



 

//   Db(this.databasePath) {
//     db = sqlite3.open(databasePath);
//     debugPrint("open database");
//   }




  

//   Future<List<TableBean>> queryAllTables() async {
//     final ResultSet resultSet = db.select(
//         "SELECT name FROM sqlite_master where type = \"table\" ORDER BY name");
//     debugPrint("select all tables");
//     StringBuffer buffer = StringBuffer();
//     List<TableBean> tables = List.empty(growable: true);

//     for (var element in resultSet) {
//       for (var value in element.values) {
//         buffer.write(value);
//         var bean = TableBean(value);
//         tables.add(bean);
//       }
//     }
//     debugPrint(buffer.toString());
//     return tables;
//   }

//   Future<List<ColumnInfo>> queryAllColumn(String tableName) async {
//     final ResultSet resultSet = db.select("PRAGMA table_info ([$tableName])");
//     debugPrint("select all columns");

//     List<ColumnInfo> columns = List.empty(growable: true);
//     debugPrint(resultSet.toString());

//     for (var element in resultSet) {
//       String name = element.values.elementAt(1);
//       String type = element.values.elementAt(2);
//       String defaultValue = element.values.elementAt(4) ?? "";
//       var columnInfo = ColumnInfo(name, type, defaultValue: defaultValue);
//       columns.add(columnInfo);
//       debugPrint(columnInfo.toString());
//     }
//     return columns;
//   }

//   Future<List<String>> queryAll(String tableName) async {
//     final ResultSet resultSet = db.select(" select * from ([$tableName])");
//     debugPrint("select all columns");
//     List<String> columns = List.empty(growable: true);
//     debugPrint(resultSet.toString());

//     for (var element in resultSet) {
//       // String name = element.values.elementAt(1);
//       // String type = element.values.elementAt(2);
//       // String defaultValue = element.values.elementAt(4) ?? "";
//       // var columnInfo = ColumnInfo(name, type, defaultValue: defaultValue);
//       // columns.add(columnInfo);
//       debugPrint(element.values.toString());
//     }
//     return columns;
//   }
// }
