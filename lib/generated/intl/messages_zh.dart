// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(value) => "成功添加一条信息，ID为${value}";

  static String m1(value) => "成功删除${value}条数据";

  static String m2(tableName) => "确定删除${tableName}表吗？";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于我"),
        "add_data_fail": MessageLookupByLibrary.simpleMessage("添加数据失败"),
        "add_data_success": m0,
        "app_name": MessageLookupByLibrary.simpleMessage("Sqlite Browser"),
        "author_name": MessageLookupByLibrary.simpleMessage("天涯浪子"),
        "auto_increment": MessageLookupByLibrary.simpleMessage("自增"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "create_database_fail": MessageLookupByLibrary.simpleMessage("新建数据库失败"),
        "create_database_fail_exist_tip":
            MessageLookupByLibrary.simpleMessage("数据库创建失败，数据库已存在！"),
        "database_name": MessageLookupByLibrary.simpleMessage("数据库名称"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "delete_success": m1,
        "delete_table_tip": m2,
        "input_database_name_tip":
            MessageLookupByLibrary.simpleMessage("请输入数据库名称"),
        "input_name_hint": MessageLookupByLibrary.simpleMessage("请输入表名"),
        "my_wechat": MessageLookupByLibrary.simpleMessage("我的微信"),
        "name": MessageLookupByLibrary.simpleMessage("名称"),
        "new_database": MessageLookupByLibrary.simpleMessage("新建数据库"),
        "new_file": MessageLookupByLibrary.simpleMessage("新建"),
        "new_table": MessageLookupByLibrary.simpleMessage("新建表"),
        "not_choose_file": MessageLookupByLibrary.simpleMessage("没有选择文件"),
        "not_null": MessageLookupByLibrary.simpleMessage("非空"),
        "null_name_tip": MessageLookupByLibrary.simpleMessage("名称不能为空"),
        "open_database": MessageLookupByLibrary.simpleMessage("打开数据库"),
        "primary_key": MessageLookupByLibrary.simpleMessage("主键"),
        "quick": MessageLookupByLibrary.simpleMessage("退出"),
        "slogan": MessageLookupByLibrary.simpleMessage("技术改变生活!"),
        "sure": MessageLookupByLibrary.simpleMessage("确定"),
        "table_name": MessageLookupByLibrary.simpleMessage("表名"),
        "type": MessageLookupByLibrary.simpleMessage("类型"),
        "unique": MessageLookupByLibrary.simpleMessage("唯一")
      };
}
