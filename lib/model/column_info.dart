class ColumnInfo {
  String columnName;
  String type;
  String defaultValue = "";
  bool isNull = false;
  bool primaryKey = false;
  bool unique = false;
  bool autoIncrement = false;
  ColumnInfo(
      {this.columnName = "", this.type = "TEXT", this.defaultValue = ""});

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    buffer.write("$columnName ");
    buffer.write("$type ");

    return "$columnName $type $defaultValue";
  }
}
