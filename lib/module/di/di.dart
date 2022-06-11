import 'package:get_it/get_it.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';

final di = GetIt.instance;
void setUpDI() {
  di.registerFactory<SqfliteCRUID>(() => SqfliteCRUID());
  di.registerFactory<TaskCRUID>(() => TaskCRUID());
}
