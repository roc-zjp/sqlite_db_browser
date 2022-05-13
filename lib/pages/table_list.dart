import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

class TableList extends StatelessWidget {
  final List<TableInfo>? tables;
  final Function(TableInfo) onTap;

  const TableList({Key? key, this.tables, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return tables == null
        ? Container(height: 200)
        : ListView(children: [for (var info in tables!) _buildTableItem(info)]);
  }

  Widget _buildTableItem(TableInfo bean) {
    return InkWell(
      onTap: () async {
        bean.expanded = !bean.expanded;
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
                              const Padding(padding: EdgeInsets.only(left: 30)),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 10)),
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
