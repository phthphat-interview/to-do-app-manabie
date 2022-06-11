part of './task_cruid.dart';

class SqfliteCRUID {
  Database? _database;

  Database getDb() {
    assert(_database != null, "Please call openDb first");
    return _database!;
  }

  Future<void> openDb({Future<void> Function(Database)? onOpened}) async {
    if (_database != null) {
      //db has already been opened
      onOpened?.call(_database!);
      return;
    }
    var db = await openDatabase(
      join(await getDatabasesPath(), "app_db.db"),
      version: 1,
      onOpen: onOpened,
    );
    _database = db;
  }
}

class SQLError {
  final String message;
  final int? code;

  SQLError(this.message, this.code);
}
