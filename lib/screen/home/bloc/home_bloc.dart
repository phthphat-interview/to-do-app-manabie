import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_manabie/module/app_error/simple_error.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<CreateTaskEvent>(_onCreateTask);
  }

  void _onCreateTask(CreateTaskEvent event, Emitter<HomeState> emit) {
    emit(TaskCreatedState(event.task));
  }

  //Logic
  Task createTask(String title, String description) {
    if (title.isEmpty) {
      throw const SimpleError(message: "Title is required");
    }
    final task = Task(title: title, description: description == "" ? null : description);
    return task;
  }
}
