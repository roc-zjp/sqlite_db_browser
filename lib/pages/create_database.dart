// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlite_db_browser/common/consts.dart';

import 'package:sqlite_db_browser/common/edit_dialog.dart';

import 'package:sqlite_db_browser/model/column_info.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';

import '../generated/l10n.dart';

class NewDatabasePage extends StatefulWidget {
  const NewDatabasePage({Key? key}) : super(key: key);

  @override
  State<NewDatabasePage> createState() => _NewDatabasePageState();
}

class _NewDatabasePageState extends State<NewDatabasePage> {
  final tableColumnInfos = List<ColumnInfo>.empty(growable: true);
  static const double typeWidth = 100.0;
  static const double itemWidth = 40.0;

  @override
  void initState() {
    super.initState();
    tableColumnInfos.add(ColumnInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.new_database),
        actions: [
          IconButton(
              onPressed: () {
                editTableName();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Stack(children: [
        SizedBox(
          height: 40,
          child: _buildFieldTitle(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: ListView(
            children: tableColumnInfos.map((e) => _buildFieldItem(e)).toList(),
          ),
        ),
        Positioned(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                tableColumnInfos.add(ColumnInfo());
              });
            },
            child: const Icon(Icons.add),
          ),
          right: 20,
          bottom: 20,
        )
      ]),
    );
  }

  Widget _buildFieldItem(ColumnInfo info) {
    var controller = TextEditingController(text: info.columnName);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
              child: TextField(
                decoration:  InputDecoration(
                    border: const OutlineInputBorder(), labelText: S.current.name),
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    info.columnName = value;
                  });
                },
              ),
            ),
          ),
          Container(
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: const Color(0xFFF8F8F8), width: 0.5)),
            width: typeWidth,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: info.type,
                  items: _buildFieldTypeItem(),
                  onChanged: (type) {
                    if (type != null) {
                      setState(() {
                        info.type = type;
                      });
                    }
                  }),
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: Checkbox(
                value: info.isNotNull,
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      info.isNotNull = v;
                    });
                  }
                }),
          ),
          SizedBox(
            width: itemWidth,
            child: Checkbox(
                value: info.primaryKey,
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      info.primaryKey = v;
                    });
                  }
                }),
          ),
          SizedBox(
            width: itemWidth,
            child: Checkbox(
                value: info.unique,
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      info.unique = v;
                    });
                  }
                }),
          ),
          SizedBox(
            width: itemWidth,
            child: Checkbox(
                value: info.autoIncrement,
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      info.autoIncrement = v;
                    });
                  }
                }),
          ),
        ],
      ),
    );
  }

  void editTableName() {
    if (!validate()) {
      EasyLoading.showToast("??????????????????");
      return;
    }
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return EditDialog(
            labelText: S.current.name,
            hintText: S.current.input_name_hint,
          );
        })).then((value) {
      if (value == null || value.isEmpty) {
        return;
      }
      createDatabase(value);
    });
  }

  void createDatabase(String tableName) async {
    StringBuffer buffer = StringBuffer();
    buffer.write("CREATE TABLE $tableName (");

    for (var i = 0; i < tableColumnInfos.length; i++) {
      var element = tableColumnInfos[i];
      buffer.write(element.toString());
      if (i != tableColumnInfos.length - 1) {
        buffer.write(",");
      }
    }
    buffer.write(")");
    logger.d(buffer.toString());

    LocalDb.instance.createTable(buffer.toString()).then((value) {
      if (value) {
        Navigator.of(context).pop();
      } else {
        EasyLoading.showToast(S.current.create_database_fail);
      }
    });
  }

  bool validate() {
    for (var element in tableColumnInfos) {
      if (element.columnName.isEmpty) {
        return false;
      }
    }
    return true;
  }

  List<DropdownMenuItem<String>> _buildFieldTypeItem() {
    return fieldTypes
        .map((e) =>
            DropdownMenuItem<String>(value: e, child: Text(e.toString())))
        .toList();
  }

  Widget _buildFieldTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children:  [
          Expanded(
              flex: 1,
              child: Text(
                S.current.name,
              )),
          SizedBox(
            width: typeWidth,
            child: Text(
              S.current.type,
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: Text(
              S.current.not_null,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: Text(
              S.current.primary_key,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: Text(
              S.current.unique,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: Text(
              S.current.auto_increment,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

List<String> fieldTypes = ["TEXT", "INTEGER", "REAL", "BLOB"];
