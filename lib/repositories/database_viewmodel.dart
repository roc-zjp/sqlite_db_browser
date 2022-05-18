import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

class DataBaseViewModel extends ChangeNotifier {
  final List<TableInfo> _tables = List.empty(growable: true);
  TableInfo? _selectedTableInfo;
  List<TableInfo> get tables => _tables;
  

  TableInfo? get selectedTableInfo => _selectedTableInfo;

  void onDatabaseChange(List<TableInfo> tables) {
    _tables.clear();
    _tables.addAll(tables);
    _selectedTableInfo = null;
    notifyListeners();
  }

  void onTableSelected(TableInfo info) {
    if (selectedTableInfo != info) {
      _selectedTableInfo = info;
      notifyListeners();
    }
  }
}
