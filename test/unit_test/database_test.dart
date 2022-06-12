import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_manabie/module/di/di.dart';
import 'package:todo_manabie/module/environment/environment_manager.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

void main() {
  // Set up Sqflite for testing, refer: https://github.com/tekartik/sqflite/blob/master/sqflite/doc/testing.md

  late TaskCRUID taskDAO;
  late SqfliteManagement sqflite;

  setUpAll(() async {
    setUpDI();
    EnvironmentManager.setEnvironment(Environment.testing);
    sqfliteTestInit();
    taskDAO = di<TaskCRUID>();
    sqflite = di<SqfliteManagement>();
    await taskDAO.prepareDb();
  });

  test("Test whether db is connected", () async {
    expect(() async {
      var a = di<SqfliteManagement>();
      expect(a, sqflite);
    }, returnsNormally);
  });

  test("Test insert a task", () async {
    expect(await taskDAO.count(), 0);

    final task = Task(title: "Test", description: "Test description");
    final insertedTask = await taskDAO.create(task);

    expect(await taskDAO.count(), 1);

    //Expect the first task id is 1
    expect(insertedTask.id, 1);
  });

  test("Verify the data inserted equal to the data get by id", () async {
    final task = Task(title: "Test", description: "Test description");

    final insertedTask = await taskDAO.create(task);

    final taskFromDb = await taskDAO.getById(insertedTask.id);
    expect(insertedTask, taskFromDb);
  });

  test("Update a task record", () async {
    var task = Task(id: 123, title: "Mot con vit xoe ra 2 cai canh", description: "Sua tuoi nguyen chat 100%");
    expect(() => taskDAO.update(task), throwsException); //update fail
    //try to add this task
    task.id = -1;
    expect(() async {
      var createdTask = await taskDAO.create(task);
      //try update a title
      createdTask.title = "7 vien ngoc rong";
      expect(() async => await taskDAO.update(createdTask), returnsNormally);
    }, returnsNormally);
  });

  tearDownAll(() {
    sqflite.getDb().close();
  });
}
