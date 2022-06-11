import 'package:equatable/equatable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_manabie/module/di/di.dart';
import 'package:todo_manabie/module/environment/environment_manager.dart';

part 'sqflite_management.dart';
part './task.dart';

class TaskCRUID {
  final SqfliteManagement _sqfliteCRUID = di<SqfliteManagement>();

  Future<void> prepareDb() async {
    await _sqfliteCRUID.openDb(
      onOpened: (Database db) async {
        await db.execute(
          """
          CREATE TABLE IF NOT EXISTS task (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT NOT NULL,
            description TEXT, 
            isDone INTEGER DEFAULT ${TaskStatus.notDone.value}
          );
          """,
        );
        // delete all remain tasks for testing
        if (env.isTesting) {
          await db.execute(
            """
            DELETE FROM task;
            """,
          );
        }
      },
    );
    return;
  }

  ///allow only task id -1
  Future<Task> create(Task task) async {
    assert(task.id == -1, "Task id must be -1");
    int id = await _sqfliteCRUID.getDb().insert(
          "task",
          task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    task.id = id;
    return task;
  }

  Future<int> count() async {
    return Sqflite.firstIntValue(
          await _sqfliteCRUID.getDb().rawQuery(
                "SELECT COUNT(*) FROM task",
              ),
        ) ??
        0;
  }

  Future<Task> update(Task task) async {
    assert(task.id != -1, "Task id must not be -1");
    final rowChange = await _sqfliteCRUID.getDb().update(
      "task",
      task.toJson(),
      where: "id = ?",
      whereArgs: [task.id],
    );
    if (rowChange == 0) {
      throw Exception("Update task failed");
    }
    return (await getById(task.id))!;
  }

  Future<Task> updateCustomCol(int id, Map<String, dynamic> data) async {
    assert(data["id"] != -1, "Task id must not be -1");
    await _sqfliteCRUID.getDb().update(
      "task",
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return (await getById(id))!;
  }

  Future<Task?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await _sqfliteCRUID.getDb().query(
          "task",
          columns: ["id", "title", "description", "isDone"],
          where: "id = ?",
          whereArgs: [id],
          limit: 1,
        );
    if (maps.isEmpty) {
      return null;
    }
    return Task.fromJson(maps.first);
  }

  Future<List<Task>> getAll() async {
    final List<Map<String, dynamic>> maps =
        await _sqfliteCRUID.getDb().query("task", columns: ["id", "title", "description", "isDone"]);
    return maps.map(Task.fromJson).toList();
  }

  Future<void> deleteAll() async {
    await _sqfliteCRUID.getDb().delete("task");
    return;
  }
}
