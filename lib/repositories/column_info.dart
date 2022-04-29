class ColumnInfo {
  final String columnName;
  final String type;
  final String? defaultValue;

  const ColumnInfo(this.columnName, this.type, {this.defaultValue = ""});

  @override
  String toString() {
    return "column name =$columnName,type=$type,default value =$defaultValue";
  }
}
