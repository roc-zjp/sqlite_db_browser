import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlite_db_browser/common/consts.dart';
import 'package:sqlite_db_browser/common/sql_languge.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';

class SqlLayout extends StatefulWidget {
  const SqlLayout({Key? key, required this.onExecuted}) : super(key: key);

  final VoidCallback onExecuted;

  @override
  State<SqlLayout> createState() => _SqlLayoutState();
}

class _SqlLayoutState extends State<SqlLayout> {
  var controllser = TextEditingController();
  var sqlLanguge = const SqlLanguage();
  final TextStyle _textStyle = const TextStyle(fontSize: 20);
  OverlayEntry? suggestionOverlayEntry;
  var resultStr = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: double.infinity,
                child: Builder(
                  builder: (context) => Stack(
                    children: [
                      TextField(
                        focusNode: _focusNode,
                        style: _textStyle,
                        onChanged: (value) {
                          var splited = value.split(" ");
                          var lastValue = splited.last;
                          var list = sqlLanguge.candidateList(lastValue);
                          // showCandidateDialog(context, list, _focusNode, value);
                          // showOverlaidTag(context, value, _focusNode);
                        },
                        keyboardType: TextInputType.text,
                        maxLines: 20,
                        controller: controllser,
                        decoration: const InputDecoration(
                          hintText: "请输入文字",
                          border: InputBorder.none,
                        ),
                      ),
                      Positioned(
                          right: 10,
                          bottom: 0,
                          child: TextButton(
                            child: const Text("执行"),
                            onPressed: () {
                              var text = controllser.text;
                              if (text.isEmpty) {
                                return;
                              }
                              executeSql(text);
                            },
                          ))
                    ],
                  ),
                )),
          ),
          flex: 1,
        ),
        Container(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              resultStr,
              style: TextStyle(fontSize: 18, color: Colors.red.shade600),
            ),
          ),
        )
      ],
    );
  }

  void executeSql(String sql) {
    LocalDb.instance.db?.execute(sql).then((value) {
          widget.onExecuted();
          EasyLoading.showToast("执行成功！");
          setState(() {
            resultStr = "执行成功";
          });
        }).onError((error, stackTrace) {
          logger.e("", error, stackTrace);
          setState(() {
            resultStr = error.toString();
          });
        }) ??
        EasyLoading.showToast("当前未连接数据库");
  }

  // Future showCandidateDialog(BuildContext context, List<String> candidat,
  //     FocusNode node, String text) {
  //   RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   var offset = renderBox.localToGlobal(Offset.zero);

  //   TextPainter painter = TextPainter(
  //     textDirection: TextDirection.ltr,
  //     text: TextSpan(
  //       style: _textStyle,
  //       text: text,
  //     ),
  //   );
  //   painter.layout();
  //   final textWidth = painter.width;
  //   final textHeight = painter.height;
  //   final widgetWidth = renderBox.size.width;
  //   final offsetX = textWidth % widgetWidth;
  //   final offsetY = (textWidth - offsetX) / widgetWidth * textHeight;

  //   final left = offset.dx + offsetX;
  //   final top = offset.dy + offsetY;
  //   //*The right does not indicates the width
  //   final right = left + renderBox.size.width;

  //   logger.d(textWidth);
  //   logger.d(textHeight);
  //   logger.d(offsetY);
  //   logger.d(offsetY);

  //   return showMenu(
  //       context: context,
  //       position: RelativeRect.fromLTRB(left, top, 0.0, 0.0),
  //       items: [
  //         const PopupMenuItem<String>(child: Text('Doge'), value: 'Doge'),
  //         const PopupMenuItem<String>(child: Text('Lion'), value: 'Lion'),
  //       ]);
  // }

  // showOverlaidTag(BuildContext context, String newText, FocusNode node) async {
  //   RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   var offset = renderBox.localToGlobal(Offset.zero);
  //   TextPainter painter = TextPainter(
  //     textDirection: TextDirection.ltr,
  //     text: TextSpan(
  //       style: _textStyle,
  //       text: newText,
  //     ),
  //   );
  //   painter.layout();

  //   renderBox.size.width;

  //   final textWidth = painter.width;
  //   final textHeight = painter.height;
  //   final widgetWidth = renderBox.size.width;
  //   final offsetX = textWidth % widgetWidth;
  //   final offsetY =
  //       (textWidth - offsetX) / widgetWidth * textHeight + textHeight;

  //   final left = offset.dx + offsetX;
  //   final top = offset.dy + offsetY;
  //   //*The right does not indicates the width
  //   final right = left + renderBox.size.width;

  //   // logger.d(textWidth);
  //   // logger.d(textHeight);
  //   // logger.d(offsetY);
  //   // logger.d(offsetY);

  //   OverlayState? overlayState = Overlay.of(context);
  //   if (suggestionOverlayEntry != null) {
  //     suggestionOverlayEntry!.remove();
  //   }

  //   suggestionOverlayEntry = OverlayEntry(builder: (context) {
  //     return Positioned(
  //       // Decides where to place the tag on the screen.
  //       top: top,
  //       left: left,
  //       width: 100,
  //       // Tag code.
  //       child: Material(
  //         child: Column(
  //           children: [
  //             ListTile(
  //               title: Text("dada"),
  //               hoverColor: Colors.grey,
  //               onTap: () {},
  //             ),
  //             ListTile(
  //               title: Text("dada"),
  //               hoverColor: Colors.grey,
  //               onTap: () {},
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  //   overlayState?.insert(suggestionOverlayEntry!);
  // }
}
