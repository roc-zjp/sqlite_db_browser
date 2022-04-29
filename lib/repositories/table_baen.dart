import 'package:sqlite_db_browser/repositories/column_info.dart';

class TableBean {
  List<ColumnInfo> columns = List.empty();
  final String tableName;
  String? primaryKey;
  bool expanded = false;

  TableBean(this.tableName);
}
