import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_manabie/module/app_error/simple_error.dart';
import 'package:todo_manabie/module/di/di.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';
import 'package:todo_manabie/screen/home/sub_screen/task_screen_type.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _taskDAO = di<TaskCRUID>();
  HomeBloc() : super(HomeInitial()) {
    on<CreateTaskEvent>(_onCreateTask);
    on<TaskTypeChangeEvent>(_onChangeTaskType);
  }

  void _onCreateTask(CreateTaskEvent event, Emitter<HomeState> emit) async {
    try {
      final taskCreated = await _taskDAO.create(event.task);
      emit(TaskCreatedState(taskCreated));
    } catch (e) {}
  }

  void _onChangeTaskType(TaskTypeChangeEvent event, Emitter<HomeState> emit) async {
    try {
      var task = event.task;
      task.status = task.status == TaskStatus.done ? TaskStatus.notDone : TaskStatus.done;
      final taskUpdated = await _taskDAO.updateCustomCol(event.task.id, {
        Task.statusCol: task.status.value,
      });
      emit(TaskTypeChangeState(taskUpdated));
    } catch (e) {
      print(e);
    }
  }

  //Logic
  Task createTask(String title, String description) {
    if (title.isEmpty) {
      throw const SimpleError(message: "Title is required");
    }
    final task = Task(title: title, description: description == "" ? null : description);
    return task;
  }

  Future<List<Task>> getTaskList(TaskScreenType type) async {
    return _taskDAO.getAll(type);
  }
}
