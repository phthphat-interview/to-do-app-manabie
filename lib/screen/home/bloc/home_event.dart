part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class CreateTaskEvent implements HomeEvent {
  final Task task;
  const CreateTaskEvent(this.task);
}
