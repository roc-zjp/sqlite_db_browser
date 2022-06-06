import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/pages/developer_page.dart';
import 'package:sqlite_db_browser/pages/sql_layout.dart';
import 'package:sqlite_db_browser/pages/table_date_detail.dart';
import 'package:sqlite_db_browser/pages/table_list.dart';

import '../generated/l10n.dart';
import '../repositories/table_baen.dart';

class DesktopLayout extends StatefulWidget {
  final List<TableInfo> tables;
  final TableInfo? selectedTableInfo;
  final Function(TableInfo) onTableChange;
  final Function() onCreateNewTable;
  final Function() onDeleteTable;
  final VoidCallback refreshData;

  const DesktopLayout(
      {Key? key,
      required this.tables,
      this.selectedTableInfo,
      required this.onTableChange,
      required this.onCreateNewTable,
      required this.onDeleteTable,
      required this.refreshData})
      : super(key: key);

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffeaeaea),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildSideBar(),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 0),
                child: SizedBox(
                  child: currentTabIndex == 0
                      ? _buildDataLayout()
                      : currentTabIndex == 1
                          ? _buildSqlLayout()
                          : const DeveloperPage(),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSideBar() {
    return Container(
      width: 60,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () {
              setState(() {
                currentTabIndex = 0;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: currentTabIndex == 0
                      ? Colors.black38
                      : Colors.transparent),
              width: 50,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/data.png",
                    width: 25,
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      S.current.data,
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () {
              setState(() {
                currentTabIndex = 1;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: currentTabIndex == 1
                      ? Colors.black38
                      : Colors.transparent),
              width: 50,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/sql.png",
                    width: 25,
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      "SQL",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          // const Padding(padding: EdgeInsets.only(top: 10)),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       currentTabIndex = 2;
          //     });
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //         borderRadius: const BorderRadius.all(Radius.circular(5)),
          //         color: currentTabIndex == 2
          //             ? Colors.black38
          //             : Colors.transparent),
          //     width: 50,
          //     height: 50,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           "assets/test.png",
          //           width: 25,
          //           height: 25,
          //         ),
          //         const Padding(
          //           padding: EdgeInsets.only(top: 3),
          //           child: Text(
          //             "TEST",
          //             style: TextStyle(fontSize: 10, color: Colors.white),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildDataLayout() {
    return SizedBox(
      child: Row(
        children: [
          Container(
            color: const Color(0xff383F51),
            width: 260,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TableList(
                  expandable: true,
                  tables: widget.tables,
                  onTap: (TableInfo info) {
                    setState(() {
                      widget.onTableChange(info);
                    });
                  },
                  onDeleteTable: widget.onDeleteTable,
                  onCreateNewTable: widget.onCreateNewTable,
                )),
          ),
          Expanded(
              child: widget.selectedTableInfo == null
                  ? Container(
                      color: const Color(0xffeaeaea),
                    )
                  : TableDetailPage(
                      widget.selectedTableInfo!,
                      key: ValueKey(widget.selectedTableInfo?.tableName),
                    ))
        ],
      ),
    );
  }

  Widget _buildSqlLayout() {
    return SqlLayout(
      onExecuted: widget.refreshData,
    );
  }
}
