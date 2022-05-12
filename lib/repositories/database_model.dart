import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

class DatabaseModel extends ChangeNotifier {
  final List<TableInfo> _tables = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<TableInfo> get tabels => UnmodifiableListView(_tables);

  void add(TableInfo bean) {
    _tables.add(bean);
    notifyListeners();
  }
}
