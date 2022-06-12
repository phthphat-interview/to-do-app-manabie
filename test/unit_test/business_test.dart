import 'package:flutter_test/flutter_test.dart';
import 'package:todo_manabie/module/app_error/simple_error.dart';
import 'package:todo_manabie/module/di/di.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';
import 'package:todo_manabie/screen/home/bloc/home_bloc.dart';

void main() {
  setUpAll(() {
    setUpDI();
  });
  test("Test create a task with different input", () {
    final _homeBloc = HomeBloc();

    expect(
      () => _homeBloc.createTask("Hom nay toi se day som lau nha", "Nha do qua rui"),
      returnsNormally,
    );

    expect(
      () => _homeBloc.createTask("", ""),
      throwsA(isA<SimpleError>()),
    );
    expect(
      () => _homeBloc.createTask("", "Mot vong trai bap, anh ngoi xem, em ngoi an, ben canh nhau"),
      throwsA(isA<SimpleError>()),
    );
    expect(() => _homeBloc.createTask("Maybe once you tell me why, there are funny in your eyes", ""), returnsNormally);
  });

  test("Test the task created data", () {
    final _homeBloc = HomeBloc();
    var taskCreated = _homeBloc.createTask("1 + 1 = 2", "Toan lop 1 that easy");
    expect(taskCreated.status, TaskStatus.notDone);
    //test the toggle status
    taskCreated.toggleStatus();
    expect(taskCreated.status, TaskStatus.done);
  });
}
