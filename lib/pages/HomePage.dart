// ignore_for_file: file_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:sqlite_db_browser/common/consts.dart';
import 'package:sqlite_db_browser/pages/TableDetailPage.dart';
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
  List<TableBean> tables = List.empty();
  TableBean? selectedTable;
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
        children: [_buildLeft(), _buildRight(selectedTable)],
      ),
    );
  }

  Widget _buildLeft() {
    return Container(
      width: 200,
      height: double.infinity,
      color: Colors.green,
      child: SingleChildScrollView(
        child: Column(
          children: tables.map((bean) => _buildTableItem(bean)).toList(),
        ),
      ),
    );
  }

  Widget _buildRight(TableBean? tableBean) {
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

  Widget _buildTableItem(TableBean bean) {
    return InkWell(
      onTap: () async {
        if (bean.columns.isEmpty) {
          var columns = await LocalDb.instance.queryAllColumn(bean);
          bean.columns = columns;
        }
        bean.expanded = !bean.expanded;
        setState(() {
          selectedTable = bean;
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: bean.tableName == selectedTable?.tableName
                ? Colors.blue
                : Colors.grey),
        child: Column(
          children: [
            Text(
              bean.tableName,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              maxLines: 1,
              textAlign: TextAlign.start,
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(

    );
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
