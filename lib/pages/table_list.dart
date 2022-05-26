import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

import '../generated/l10n.dart';
import 'create_database.dart';

class TableList extends StatelessWidget {
  final List<TableInfo>? tables;
  final Function(TableInfo) onTap;
  final Function() onCreateNewTable;
  final Function() onDeleteTable;

  final bool expandable;

  const TableList(
      {Key? key,
      this.tables,
      required this.expandable,
      required this.onTap,
      required this.onCreateNewTable,
      required this.onDeleteTable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tables == null
        ? Container(height: 200)
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ListView(children: [
                  for (var info in tables!) _buildTableItem(context, info)
                ]),
              ),
              if (LocalDb.instance.db != null)
                Positioned(
                    right: 10,
                    left: 10,
                    bottom: 5,
                    child: OutlinedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            primary: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      const NewDatabasePage()))
                              .then((value) => onCreateNewTable());
                        },
                        child:  SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              S.current.new_table,
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )))
            ],
          );
  }

  Widget _buildTableItem(BuildContext context, TableInfo bean) {
    return InkWell(
      onTap: () async {
        if (expandable) {
          bean.expanded = !bean.expanded;
        }
        onTap(bean);
      },
      onLongPress: () {
        showDeleteDialog(context, bean.tableName)
            .then((value) => onDeleteTable());
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
              ),
            const Divider(
              height: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Future showDeleteDialog(BuildContext context, String tableName) {
    return showCupertinoDialog(
        context: context,
        builder: ((context) {
          return CupertinoAlertDialog(
            content: Text(
              S.current.delete_table_tip(tableName),
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              CupertinoButton(
                  child:  Text(
                    S.current.delete,
                    style: const TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    LocalDb.instance
                        .delateTable(tableName)
                        .then((value) => Navigator.pop(context));
                  }),
              CupertinoButton(
                  child:  Text(S.current.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        }));
  }
}
