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
        ? Container(
            height: 200,
          )
        : ListView(
            children: [for (var info in tables!) _buildTableItem(info)],
          );
  }

  Widget _buildTableItem(TableInfo bean) {
    return InkWell(
      onTap: () async {
        bean.expanded = !bean.expanded;
        onTap(bean);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(color: Colors.grey),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomRight: Radius.circular(25))
              ),
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
                      style: const TextStyle(color: Colors.black, fontSize: 20),
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
                children: bean.columns
                    .map((item) => Text(
                          item.columnName,
                          style: const TextStyle(
                              color: Colors.black38, fontSize: 18),
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
