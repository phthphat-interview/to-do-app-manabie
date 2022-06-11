part of './task_cruid.dart';

class SqfliteManagement {
  Database? _database;

  Database getDb() {
    if (_database == null) {
      throw SQLError("Database is not connected, please call openDb first");
    }
    return _database!;
  }

  Future<void> openDb({Future<void> Function(Database)? onOpened}) async {
    if (_database != null) {
      //db has already been opened
      onOpened?.call(_database!);
      return;
    }
    var db = await openDatabase(
      env.isTesting ? inMemoryDatabasePath : join(await getDatabasesPath(), "app_db.db"),
      version: 1,
      onOpen: onOpened,
    );
    _database = db;
  }
}

class SQLError extends Error {
  final String message;
  final int? code;

  SQLError(this.message, [this.code]);
}
