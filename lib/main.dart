import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:sqlite_db_browser/pages/desktop_layout.dart';
import 'package:sqlite_db_browser/pages/mobile_layout.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';
import 'package:sqlite_db_browser/repositories/table_baen.dart';

import 'common/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          LayoutBuilder(builder: ((context, constraints) => const MainPage())),
      builder: EasyLoading.init(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<TableInfo> tables = List.empty();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
                onPressed: () {
                  onOpenDatabase();
                },
                icon: Image.asset("assets/file-open.png")),
          )
        ],
      ),
      body:
          (kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows)
              ? DesktopLayout(
                  tables: tables,
                )
              : MobileLayout(
                  tables: tables,
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
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File? file;

    if (result != null && result.files.single.path != null) {
      file = File(result.files.single.path!);
      logger.d("filepath =${file.path}");
    } else {
      logger.d("没有选择文件");
    }
    return file;
  }
}
