class ColumnInfo {
  String columnName;
  String type;
  String defaultValue = "";
  bool isNotNull = false;
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

    if(primaryKey){
      buffer.write("PRIMARY KEY ");
    }

    if(autoIncrement){
      buffer.write("AUTOINCREMENT ");
    }

    if(isNotNull){
      buffer.write("NOT NULL ");
    }


    if(unique){
      buffer.write("UNIQUE ");
    }



    return buffer.toString();
  }
}
