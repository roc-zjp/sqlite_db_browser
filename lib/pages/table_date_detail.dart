// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlite_db_browser/common/consts.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

class TableDetailPage extends StatefulWidget {
  final TableInfo bean;

  const TableDetailPage(this.bean, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TableDetailState();
  }
}

class TableDetailState extends State<TableDetailPage> {
  List<Map<String, Object?>> datas = List.empty();
  int _rowPage = 10;

  @override
  void initState() {
    super.initState();
    refreshDatas();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTableInfo(widget.bean);
  }

  Widget _buildTableInfo(TableInfo info) {
    var _dataSources = TableDataSource(datas, info.primaryKey, (index) {
      showEditDialog(info, datas[index], update: true)
          .then((value) => refreshDatas());
    }, selectAble: info.primaryKey != null);

    return SingleChildScrollView(
      primary: false,
      child: SizedBox(
        width: double.infinity,
        child: PaginatedDataTable(
          columns: widget.bean.columns
              .map((e) => DataColumn(
                      label: Center(
                    child: Text(e.columnName),
                  )))
              .toList(growable: true),
          source: _dataSources,
          actions: [
            if (info.primaryKey != null)
              IconButton(
                  onPressed: () {
                    deleteDatas(info.tableName, info.primaryKey!,
                        List.from(_dataSources.selectedList));
                  },
                  icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  showEditDialog(widget.bean, null, update: false)
                      .then((value) => refreshDatas());
                },
                icon: const Icon(Icons.add))
          ],
          header: const Text("数据"),
          availableRowsPerPage: const [10, 20, 50, 100],
          rowsPerPage: _rowPage,
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowPage = value ?? _rowPage;
            });
          },
          onSelectAll: (selected) {
            if (selected == null) return;
            if (selected) {
              _dataSources.selectAll();
            } else {
              _dataSources.clearAll();
            }
          },
        ),
      ),
    );
  }

  Future showEditDialog(TableInfo bean, Map<String, Object?>? dataRead,
      {bool update = false}) {
    var map = (dataRead == null)
        ? <String, Object?>{}
        : Map<String, Object?>.from(dataRead);

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ...bean.columns
                      .map((columnInfo) => _buildSheetItem(
                              columnInfo.columnName,
                              map[columnInfo.columnName],
                              columnInfo.type, (key, newValue) {
                            map[key] = newValue;
                          }))
                      .toList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: TextButton(
                            child: const Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )),
                      TextButton(
                          onPressed: () {
                            updateOrInsertData(bean, map, update);
                          },
                          child: const Text("确定"))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future refreshDatas() async {
    var readDatas = await LocalDb.instance.queryAll(widget.bean.tableName);
    var writeDatas = List<Map<String, Object?>>.from(readDatas);
    setState(() {
      datas = writeDatas;
    });
  }

  void deleteDatas(String tableName, String primaryKey, List list) {
    LocalDb.instance
        .deleteAllByPrimaryKeys(tableName, primaryKey, List.from(list))
        .then((value) => EasyLoading.showToast('成功删除$value条数据')
            .then((value) => refreshDatas()));
  }

  void updateOrInsertData(
      TableInfo bean, Map<String, Object?> map, bool update) {
    if (update) {
      LocalDb.instance
          .update(bean.tableName, map, bean.primaryKey!)
          .then((value) {
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        logger.e("on error:${error.toString()}");
        EasyLoading.showError("添加数据失败")
            .then((value) => Navigator.of(context).pop());
      });
    } else {
      LocalDb.instance.insert(bean.tableName, map).then((value) {
        EasyLoading.showToast('成功添加一条信息，ID为$value')
            .then((value) => Navigator.of(context).pop());
      }).onError((error, stackTrace) {
        logger.e("on error:${error.toString()}");
        EasyLoading.showError("添加数据失败")
            .then((value) => Navigator.of(context).pop());
      });
    }
  }

  void func = (String newValue) {};

  Widget _buildSheetItem(
      String key, Object? value, String type, Function func) {
    TextEditingController controller =
        TextEditingController(text: value == null ? "" : value.toString());

    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(key),
          ),
          Expanded(
              flex: 1,
              child: TextField(
                onChanged: ((value) {
                  func(key, value);
                }),
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ))
        ],
      ),
    );
  }
}

typedef OnClick = Function(int index);

class TableDataSource extends DataTableSource {
  final List<Map<String, Object?>> datas;
  List<dynamic> selectedList = List.empty(growable: true);
  bool selectAble = false;
  final OnClick onClick;
  final String? primaryKey;

  TableDataSource(
    this.datas,
    this.primaryKey,
    this.onClick, {
    this.selectAble = false,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= datas.length) return null;
    final Map row = datas[index];
    List<DataCell> cells = List.empty(growable: true);
    row.forEach((key, value) {
      cells.add(DataCell(Text("$value")));
    });

    return DataRow.byIndex(
        index: index,
        cells: cells,
        selected: selectAble
            ? selectedList.contains(datas[index][primaryKey])
            : false,
        onLongPress: () {
          onClick(index);
        },
        onSelectChanged: selectAble
            ? (selected) {
                if (selected == null) return;
                if (selected) {
                  selectedList.add(datas[index][primaryKey]);
                } else {
                  selectedList.remove(datas[index][primaryKey]);
                }
                notifyListeners();
              }
            : null);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => datas.length;

  @override
  int get selectedRowCount => selectedList.length;

  void selectAll() {
    selectedList.clear();
    for (var element in datas) {
      selectedList.add(element[primaryKey]);
    }
    notifyListeners();
  }

  void clearAll() {
    selectedList.clear();
    notifyListeners();
  }
}
