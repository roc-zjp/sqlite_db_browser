import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditDialog extends StatelessWidget {
  final String labelText;
  final String hintText;
  EditDialog({Key? key, this.labelText = "", this.hintText = ""})
      : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SizedBox(
          height: 210,
          width: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  maxLines: 6,
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: labelText,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "请输入表名",
                      border: const OutlineInputBorder()),
                ),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("取消")),
                  ElevatedButton(
                      onPressed: () {
                        var tableName = controller.text;
                        Navigator.pop(context, tableName);
                      },
                      child: const Text("确定"))
                ],
              )
            ],
          )),
    );
  }
}
