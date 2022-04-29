import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/common/consts.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

typedef OnUpdate = void Function(Object o);
typedef OnDelete = void Function(Object o);
typedef OnAdd = void Function(Object o);
typedef OnQuery = void Function(Object o);

class TableDetailPage extends StatefulWidget {
  final TableBean bean;
  final OnUpdate? onUpdate;
  final OnDelete? onDelete;
  final OnQuery? onQuery;

  const TableDetailPage(this.bean,
      {Key? key, this.onUpdate, this.onDelete, this.onQuery})
      : super(key: key);

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
    logger.d("TableDetailPage initState");
    super.initState();
    LocalDb.instance
        .queryAll(widget.bean.tableName)
        .then((value) => setState(() {
              List<Map<String, Object?>> writeableDatas =
                  List.empty(growable: true);
              for (var element in value) {
                writeableDatas.add(Map.from(element));
              }
              datas = writeableDatas;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return _buildTableInfo();
  }

  Widget _buildTableInfo() {
    logger.d("TableDetailPage build");
    var _dataSources = TableDataSource(datas, (index) {
      showEditDialog(datas[index]);
    }, selectAble: widget.bean.primaryKey != null);
    return SingleChildScrollView(
      primary: false,
      child: PaginatedDataTable(
        columns: widget.bean.columns
            .map((e) => DataColumn(
                    label: Center(
                  child: Text(e.columnName),
                )))
            .toList(),
        source: _dataSources,
        actions: [
          if (widget.bean.primaryKey != null)
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                showEditDialog(null);
              },
              icon: const Icon(Icons.add))
        ],
        header: const Text(""),
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
    );
  }

  Future showEditDialog(Map<String, Object?>? map) {
    var items = List<Widget>.empty(growable: true);
    map?.forEach((key, value) {
      items.add(_buildSheetItem(key, value));
    });
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ...items,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("取消")),
                    TextButton(onPressed: () {

                    }, child: const Text("确定"))
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget _buildSheetItem(String key, Object? value) {
    TextEditingController controller =
        TextEditingController(text: value.toString());
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
  List<int> selectedList = List.empty(growable: true);
  bool selectAble = false;
  final OnClick onClick;

  TableDataSource(
    this.datas,
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

    return selectAble
        ? DataRow.byIndex(
            index: index,
            cells: cells,
            selected: selectedList.contains(index),
            onLongPress: () {
              onClick(index);
            },
            onSelectChanged: (selected) {
              if (selected == null) return;
              if (selected) {
                selectedList.add(index);
              } else {
                selectedList.remove(index);
              }
              notifyListeners();
            })
        : DataRow.byIndex(
            index: index,
            cells: cells,
          );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => datas.length;

  @override
  int get selectedRowCount => selectedList.length;

  void selectAll() {
    selectedList.clear();
    for (var i = 0; i < datas.length; i++) {
      selectedList.add(i);
    }
    notifyListeners();
  }

  void clearAll() {
    selectedList.clear();
    notifyListeners();
  }
}
