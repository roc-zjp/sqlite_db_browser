import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

class DatabaseModel extends ChangeNotifier {
  final List<TableBean> _tables = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<TableBean> get tabels => UnmodifiableListView(_tables);

  void add(TableBean bean) {
    _tables.add(bean);
    notifyListeners();
  }
}
