import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_db_browser/pages/about_me.dart';
import 'package:sqlite_db_browser/pages/create_database.dart';

import 'package:sqlite_db_browser/pages/desktop_layout.dart';
import 'package:sqlite_db_browser/pages/mobile_layout.dart';
import 'package:sqlite_db_browser/repositories/database_viewmodel.dart';
import 'package:sqlite_db_browser/repositories/local_db.dart';

import 'common/consts.dart';
import 'common/edit_dialog.dart';
import 'generated/l10n.dart';

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
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
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
  final databaseModel = DataBaseViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
                tooltip: S.of(context).app_name,
                onPressed: () {
                  openDatabase();
                },
                icon: Image.asset("assets/file-open.png")),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
                tooltip: S.current.new_database,
                onPressed: () {
                  createDatabase();
                },
                icon: Image.asset("assets/new_file.png")),
          )
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => databaseModel,
        child: Consumer<DataBaseViewModel>(
          builder: (context, value, child) => (kIsWeb ||
                  Platform.isMacOS ||
                  Platform.isLinux ||
                  Platform.isWindows)
              ? _buildDesktopLayout(value)
              : MobileLayout(
                  tables: value.tables,
                  onDeleteTable: refreshData,
                  onCreateNewTable: refreshData,
                ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(DataBaseViewModel value) {
    return PlatformMenuBar(
        body: DesktopLayout(
          tables: value.tables,
          selectedTableInfo: value.selectedTableInfo,
          onTableChange: (info) {
            databaseModel.onTableSelected(info);
          },
          onDeleteTable: refreshData,
          onCreateNewTable: refreshData,
          refreshData: refreshData,
        ),
        menus: [
          PlatformMenu(label: APP_NAME, menus: [
            PlatformMenuItemGroup(
              members: <MenuItem>[
                PlatformMenuItem(
                  label: S.current.about,
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
                  label: S.current.quick,
                  onSelected: () {
                    exit(0);
                  },
                )
              ],
            ),
          ]),
          PlatformMenu(label: S.current.new_file, menus: [
            PlatformMenuItemGroup(
              members: <MenuItem>[
                PlatformMenuItem(
                  label: S.current.open_database,
                  onSelected: () {
                    openDatabase();
                  },
                )
              ],
            ),
            PlatformMenuItemGroup(
              members: <MenuItem>[
                PlatformMenuItem(
                  label: S.current.new_database,
                  onSelected: () {
                    createDatabase();
                  },
                )
              ],
            ),
            PlatformMenuItemGroup(
              members: <MenuItem>[
                PlatformMenuItem(
                  label: S.current.new_table,
                  onSelected: () {
                    if (LocalDb.instance.db != null) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => const NewDatabasePage()))
                          .then((value) => refreshData());
                    }
                  },
                )
              ],
            ),
          ])
        ]);
  }

  Future createDatabase() {
    return showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return EditDialog(
            labelText: S.current.database_name,
            hintText: S.current.input_database_name_tip,
          );
        })).then((value) async {
      if (value == null || value.isEmpty) {
        EasyLoading.showToast(S.current.input_database_name_tip);
        return;
      }
      
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      String dbPath = "$appDocPath/$value.db";
      var file = File(dbPath);

      var exists = await file.exists();
      if (exists) {
        EasyLoading.showToast(S.current.create_database_fail_exist_tip);
        return;
      }
      await LocalDb.instance.initDb(dbPath);
      var results = await LocalDb.instance.queryAllTables();
      setState(() {
        databaseModel.onDatabaseChange(results);
      });
    });
  }

  void refreshData() async {
    var results = await LocalDb.instance.queryAllTables();
    setState(() {
      databaseModel.onDatabaseChange(results);
    });
  }

  void openDatabase() async {
    var file = await pickFile();
    if (file == null) {
      return;
    }

    await LocalDb.instance.initDb(file.path);
    var results = await LocalDb.instance.queryAllTables();
    setState(() {
      databaseModel.onDatabaseChange(results);
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
