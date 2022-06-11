part of './task_cruid.dart';

class Task {
  int id; //-1 is for creating
  String title;
  String? description;
  TaskStatus status;

  Task({this.id = -1, required this.title, this.description, this.status = TaskStatus.notDone});

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      status: TaskStatusExt.fromValue(json["isDone"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != -1) 'id': id,
      'title': title,
      'description': description,
      'isDone': status.value,
    };
  }
}

enum TaskStatus { done, notDone }

extension TaskStatusExt on TaskStatus {
  int get value {
    switch (this) {
      case TaskStatus.done:
        return 1;
      case TaskStatus.notDone:
        return 0;
    }
  }

  static TaskStatus fromValue(int value) {
    for (TaskStatus status in TaskStatus.values) {
      if (status.value == value) {
        return status;
      }
    }
    return TaskStatus.notDone;
  }
}
