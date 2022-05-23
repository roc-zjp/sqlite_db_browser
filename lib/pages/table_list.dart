import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

import 'create_database.dart';

class TableList extends StatelessWidget {
  final List<TableInfo>? tables;
  final Function(TableInfo) onTap;

  final bool expandable;

  const TableList(
      {Key? key, this.tables, required this.expandable, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return tables == null
        ? Container(height: 200)
        : Stack(
            children: [
              ListView(
                  children: [for (var info in tables!) _buildTableItem(info)]),
              if (LocalDb.instance.db != null)
                Positioned(
                    right: 10,
                    left: 10,
                    bottom: 10,
                    child: OutlinedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.amber,
                            primary: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const NewDatabasePage()));
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            "新建数据库",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )))
            ],
          );
  }

  Widget _buildTableItem(TableInfo bean) {
    return InkWell(
      onTap: () async {
        if (expandable) {
          bean.expanded = !bean.expanded;
        }
        onTap(bean);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    "assets/table.png",
                    width: 20,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      bean.tableName,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            if (expandable)
              Offstage(
                offstage: !bean.expanded,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: bean.columns
                      .map((item) => SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 30)),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 10)),
                                Text(
                                  item.columnName,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
