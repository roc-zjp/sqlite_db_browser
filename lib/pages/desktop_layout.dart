import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sqlite_db_browser/common/consts.dart';
import 'package:sqlite_db_browser/pages/about_me.dart';
import 'package:sqlite_db_browser/pages/table_date_detail.dart';
import 'package:sqlite_db_browser/pages/table_list.dart';

import '../repositories/table_baen.dart';

class DesktopLayout extends StatefulWidget {
  final List<TableInfo> tables;
  final TableInfo? selectedTableInfo;
  final Function(TableInfo) onTableChange;

  const DesktopLayout(
      {Key? key,
      required this.tables,
      this.selectedTableInfo,
      required this.onTableChange})
      : super(key: key);

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  void initState() {
    super.initState();
    logger.d("desktoplayout initstate");
  }

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: [
        PlatformMenu(label: "Flutter API Sample", menus: [
          PlatformMenuItemGroup(
            members: <MenuItem>[
              PlatformMenuItem(
                label: 'About',
                onSelected: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const AboutPage();
                  }));
                },
              )
            ],
          ),
          PlatformMenuItemGroup(
            members: <MenuItem>[
              PlatformMenuItem(
                label: 'Quick Sqlite Browser',
                onSelected: () {
                  exit(0);
                },
              )
            ],
          ),
        ])
      ],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xff383F51),
            width: 260,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TableList(
                  tables: widget.tables,
                  onTap: (TableInfo info) {
                    setState(() {
                      widget.onTableChange(info);
                    });
                  },
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
}
