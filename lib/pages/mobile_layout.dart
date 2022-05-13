import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/pages/table_date_detail.dart';
import 'package:sqlite_db_browser/pages/table_list.dart';

import '../repositories/table_baen.dart';

class MobileLayout extends StatelessWidget {
  final List<TableInfo> tables;
  const MobileLayout({Key? key, required this.tables}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TableList(
            tables: tables,
            onTap: (TableInfo info) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(),
                  body: TableDetailPage(info),
                );
              }));
            },
          )),
    );
  }
}