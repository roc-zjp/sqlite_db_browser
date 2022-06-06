import 'language.dart';

class SqlLanguage extends Language {
  const SqlLanguage() : super('Sql');

  @override
  List<String> get keywords => <String>[
        'varchar',
        'char',
        'int',
        'real',
        'double',
        'precision',
        'float',
        'numeric',
        'smallint',
        'primary',
        'key',
        'create',
        'insert',
        'into',
        'delete',
        'from',
        'update',
        'set',
        'where',
        'drop',
        'table',
        'alter',
        'not',
        'null',
        'select',
        'distinct',
        'all',
        'or',
        'join',
        'as',
        '*',
        'order',
        'by',
        'desc',
        'asc',
        'between',
        'union',
        'intersect',
        'except',
        'is',
        'avg',
        'min',
        'max',
        'sum',
        'count',
        'distinct',
        'group',
        'by',
        'having',
      ];

  @override
  bool containsKeywords(String word) => keywords.contains(word);

  @override
  List<String> candidateList(String input) {
    return keywords.where((element) => element.startsWith(input)).toList();
  }
}
