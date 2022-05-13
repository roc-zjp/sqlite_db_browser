// ignore_for_file: file_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:sqlite_db_browser/common/consts.dart';
import 'package:sqlite_db_browser/pages/table_date_detail.dart';
import 'package:sqlite_db_browser/pages/table_list.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<TableInfo> tables = List.empty();
  TableInfo? selectedTable;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        actions: [
          IconButton(
              onPressed: () {
                onOpenDatabase();
              },
              icon: const Icon(Icons.open_in_browser))
        ],
      ),
      body: Row(
        children: [
          TableList(
            tables: tables,
            onTap: (TableInfo info) {
              selectedTable = info;
            },
          ),
          _buildRight(selectedTable)
        ],
      ),
    );
  }

  Widget _buildRight(TableInfo? tableBean) {
    return Expanded(
        flex: 1,
        child: Container(
          color: Colors.red,
          width: double.infinity,
          height: double.infinity,
          child: tableBean == null
              ? Container()
              : TableDetailPage(
                  selectedTable!,
                  key: GlobalKey(debugLabel: tableBean.tableName),
                ),
        ));
  }

  void onOpenDatabase() async {
    var file = await pickFile();
    if (file == null) {
      return;
    }
    await LocalDb.instance.initDb(file.path);
    var results = await LocalDb.instance.queryAllTables();
    setState(() {
      tables = results;
    });
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File? file;
    if (result != null && result.files.single.path != null) {
      file = File(result.files.single.path!);
      debugPrint("filepath =${file.path}");
    } else {
      debugPrint("没有选择文件");
    }
    return file;
  }
}
