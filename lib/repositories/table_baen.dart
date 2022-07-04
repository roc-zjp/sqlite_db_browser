import 'package:sqlite_db_browser/model/column_info.dart';

class TableInfo {
  List<ColumnInfo> columns = List.empty();
  final String tableName;
  String? primaryKey;
  bool expanded = false;
  String sql;

  TableInfo(this.tableName, {this.sql = ''});
}
