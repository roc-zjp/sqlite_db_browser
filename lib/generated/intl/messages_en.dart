// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(value) => "Succeeded in adding a message，ID is ${value}";

  static String m1(value) => "${value} pieces of data are deleted";

  static String m2(tableName) => "Are you sure to drop the ${tableName} table？";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About Me"),
        "add_data_fail": MessageLookupByLibrary.simpleMessage("Add data fail"),
        "add_data_success": m0,
        "app_name": MessageLookupByLibrary.simpleMessage("Sqlite Browser"),
        "author_name": MessageLookupByLibrary.simpleMessage("Roc"),
        "auto_increment":
            MessageLookupByLibrary.simpleMessage("Auto increment"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "create_database_fail":
            MessageLookupByLibrary.simpleMessage("Create database fail"),
        "create_database_fail_exist_tip": MessageLookupByLibrary.simpleMessage(
            "Create Database Fail,Database exist!"),
        "data": MessageLookupByLibrary.simpleMessage("Data"),
        "database_name": MessageLookupByLibrary.simpleMessage("Database Name"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "delete_success": m1,
        "delete_table_tip": m2,
        "input_database_name_tip":
            MessageLookupByLibrary.simpleMessage("Please Input Database Name"),
        "input_name_hint":
            MessageLookupByLibrary.simpleMessage("Please input table name!"),
        "my_wechat": MessageLookupByLibrary.simpleMessage("My Wechat"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "new_database": MessageLookupByLibrary.simpleMessage("New Database"),
        "new_file": MessageLookupByLibrary.simpleMessage("New File"),
        "new_table": MessageLookupByLibrary.simpleMessage("New Table"),
        "not_choose_file":
            MessageLookupByLibrary.simpleMessage("No File Chosen"),
        "not_null": MessageLookupByLibrary.simpleMessage("Not null"),
        "null_name_tip":
            MessageLookupByLibrary.simpleMessage("The name cannot be empty"),
        "open_database": MessageLookupByLibrary.simpleMessage("Open Databse"),
        "primary_key": MessageLookupByLibrary.simpleMessage("Primary key"),
        "quick": MessageLookupByLibrary.simpleMessage("Quick"),
        "slogan":
            MessageLookupByLibrary.simpleMessage("Technology Changes Life!"),
        "sure": MessageLookupByLibrary.simpleMessage("sure"),
        "table_name": MessageLookupByLibrary.simpleMessage("Table Name"),
        "type": MessageLookupByLibrary.simpleMessage("Type"),
        "unique": MessageLookupByLibrary.simpleMessage("Unique")
      };
}
