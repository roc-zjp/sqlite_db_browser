import 'package:sqlite_db_browser/model/column_info.dart';
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

  Database? get db => _database;

  String? get dataPath => _databasePath;

  static LocalDb instance = LocalDb._();

  late String _databasePath = "";

  Future<void> initDb(String databasePath) async {
    if (_databasePath == databasePath && _database != null) return;
    _databasePath = databasePath;
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var options = OpenDatabaseOptions(
        version: 1,
        onCreate: (Database db, int version) {
          logger.d("ondatabase create");
        },
        onOpen: (db) {
          logger.d("ondatabase open");
        });
    _database =
        await databaseFactory.openDatabase(databasePath, options: options);
    logger.d("数据库初始化完成");
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }

  Future<List<TableInfo>> queryAllTables() async {
    List<Map<String, Object?>> results = await db!
        .query("sqlite_master", where: 'type = ?', whereArgs: ['table']);
    List<TableInfo> tables = List.empty(growable: true);

    for (var element in results) {
      logger.d(element.toString());
      String tableName = element['name'].toString();
      String sql = element['sql'].toString();
      var info = await queryTableInfo(tableName, sql: sql);
      tables.add(info);
    }
    return tables;
  }

  Future<TableInfo> queryTableInfo(String tableName, {String sql = ""}) async {
    List<Map<String, Object?>> results =
        await db!.rawQuery("PRAGMA table_info ([$tableName])");
    List<ColumnInfo> columns = List.empty(growable: true);
    TableInfo info = TableInfo(tableName);

    for (var element in results) {
      logger.d(element);
      int pk = element['pk'] as int;
      if (pk == 1) {
        info.primaryKey = element['name'].toString();
      }
      columns.add(ColumnInfo(
          columnName: element['name'].toString(),
          type: element['type'].toString(),
          defaultValue: element['dflt_value'].toString()));
    }
    info.columns = columns;
    info.sql = sql;
    return info;
  }

  Future<bool> createTable(String createSql) async {
    bool result = await db!
        .execute(createSql)
        .then((value) => true)
        .onError((error, stackTrace) {
      logger.e(error);
      return false;
    });
    return result;
  }

  Future<List<Map<String, Object?>>> queryAll(String tableName) async {
    List<Map<String, Object?>> results = await db!.query(tableName);
    // for (var element in results) {
    //   logger.d(element);
    // }
    return results;
  }

  Future<int> deleteAllByPrimaryKeys(
      String tableName, String primaryKey, List<Object?>? selecteds) async {
    var batch = db!.batch();
    selecteds?.forEach((element) {
      batch.delete(tableName, where: '$primaryKey = ?', whereArgs: [element]);
    });
    var results = await batch.commit();
    return results.length;
  }

  Future<int> update(
      String tableName, Map<String, Object?> map, String primaryKey) async {
    int result = await db!.update(tableName, map,
        where: '$primaryKey = ?', whereArgs: [map[primaryKey]]);
    logger.d("result=$result");
    return result;
  }

  Future<int> insert(String tableName, Map<String, Object?> map) async {
    int result = await db!.insert(tableName, map);
    logger.d("result=$result");
    return result;
  }

  Future<bool> delateTable(String tableName) async {
    bool result = await db!
        .execute("DROP TABLE $tableName")
        .then((value) => true)
        .onError((error, stackTrace) => false);
    logger.d("result=$result");
    return result;
  }
}
