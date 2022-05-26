// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sqlite Browser`
  String get app_name {
    return Intl.message(
      'Sqlite Browser',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `New File`
  String get new_file {
    return Intl.message(
      'New File',
      name: 'new_file',
      desc: '',
      args: [],
    );
  }

  /// `New Database`
  String get new_database {
    return Intl.message(
      'New Database',
      name: 'new_database',
      desc: '',
      args: [],
    );
  }

  /// `New Table`
  String get new_table {
    return Intl.message(
      'New Table',
      name: 'new_table',
      desc: '',
      args: [],
    );
  }

  /// `Open Databse`
  String get open_database {
    return Intl.message(
      'Open Databse',
      name: 'open_database',
      desc: '',
      args: [],
    );
  }

  /// `About Me`
  String get about {
    return Intl.message(
      'About Me',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Quick`
  String get quick {
    return Intl.message(
      'Quick',
      name: 'quick',
      desc: '',
      args: [],
    );
  }

  /// `Database Name`
  String get database_name {
    return Intl.message(
      'Database Name',
      name: 'database_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Input Database Name`
  String get input_database_name_tip {
    return Intl.message(
      'Please Input Database Name',
      name: 'input_database_name_tip',
      desc: '',
      args: [],
    );
  }

  /// `Create Database Fail,Database exist!`
  String get create_database_fail_exist_tip {
    return Intl.message(
      'Create Database Fail,Database exist!',
      name: 'create_database_fail_exist_tip',
      desc: '',
      args: [],
    );
  }

  /// `No File Chosen`
  String get not_choose_file {
    return Intl.message(
      'No File Chosen',
      name: 'not_choose_file',
      desc: '',
      args: [],
    );
  }

  /// `Roc`
  String get author_name {
    return Intl.message(
      'Roc',
      name: 'author_name',
      desc: '',
      args: [],
    );
  }

  /// `Technology Changes Life!`
  String get slogan {
    return Intl.message(
      'Technology Changes Life!',
      name: 'slogan',
      desc: '',
      args: [],
    );
  }

  /// `My Wechat`
  String get my_wechat {
    return Intl.message(
      'My Wechat',
      name: 'my_wechat',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `The name cannot be empty`
  String get null_name_tip {
    return Intl.message(
      'The name cannot be empty',
      name: 'null_name_tip',
      desc: '',
      args: [],
    );
  }

  /// `Table Name`
  String get table_name {
    return Intl.message(
      'Table Name',
      name: 'table_name',
      desc: '',
      args: [],
    );
  }

  /// `Please input table name!`
  String get input_name_hint {
    return Intl.message(
      'Please input table name!',
      name: 'input_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Create database fail`
  String get create_database_fail {
    return Intl.message(
      'Create database fail',
      name: 'create_database_fail',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Not null`
  String get not_null {
    return Intl.message(
      'Not null',
      name: 'not_null',
      desc: '',
      args: [],
    );
  }

  /// `Primary key`
  String get primary_key {
    return Intl.message(
      'Primary key',
      name: 'primary_key',
      desc: '',
      args: [],
    );
  }

  /// `Unique`
  String get unique {
    return Intl.message(
      'Unique',
      name: 'unique',
      desc: '',
      args: [],
    );
  }

  /// `Auto increment`
  String get auto_increment {
    return Intl.message(
      'Auto increment',
      name: 'auto_increment',
      desc: '',
      args: [],
    );
  }

  /// `{value} pieces of data are deleted`
  String delete_success(Object value) {
    return Intl.message(
      '$value pieces of data are deleted',
      name: 'delete_success',
      desc: '',
      args: [value],
    );
  }

  /// `Add data fail`
  String get add_data_fail {
    return Intl.message(
      'Add data fail',
      name: 'add_data_fail',
      desc: '',
      args: [],
    );
  }

  /// `Succeeded in adding a message，ID is {value}`
  String add_data_success(Object value) {
    return Intl.message(
      'Succeeded in adding a message，ID is $value',
      name: 'add_data_success',
      desc: '',
      args: [value],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `sure`
  String get sure {
    return Intl.message(
      'sure',
      name: 'sure',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to drop the {tableName} table？`
  String delete_table_tip(Object tableName) {
    return Intl.message(
      'Are you sure to drop the $tableName table？',
      name: 'delete_table_tip',
      desc: '',
      args: [tableName],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
