part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class TaskCreatedState implements HomeState {
  final Task task;
  const TaskCreatedState(this.task);
}

class TaskTypeChangeState implements HomeState {
  final Task task;

  const TaskTypeChangeState(this.task);
}

class HomeShowBottomMessageState implements HomeState {
  final String message;
  const HomeShowBottomMessageState(this.message);
}
