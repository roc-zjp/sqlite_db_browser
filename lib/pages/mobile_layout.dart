import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/pages/table_date_detail.dart';
import 'package:sqlite_db_browser/pages/table_list.dart';

import '../repositories/table_baen.dart';

class MobileLayout extends StatelessWidget {
  final List<TableInfo> tables;
  final Function() onCreateNewTable;
   final Function() onDeleteTable;

  const MobileLayout(
      {Key? key, required this.tables, required this.onCreateNewTable,required this.onDeleteTable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff383F51),
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TableList(
            expandable: false,
            tables: tables,
            onTap: (TableInfo info) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(),
                  body: TableDetailPage(info),
                );
              }));
            },
            onDeleteTable: onDeleteTable,
            onCreateNewTable: onCreateNewTable,
          )),
    );
  }
}
