part of './task_cruid.dart';

class Task extends Equatable {
  int id; //-1 is for creating
  String title;
  String? description;
  TaskStatus status;

  static String statusCol = "status";

  Task({this.id = -1, required this.title, this.description, this.status = TaskStatus.notDone});

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      status: TaskStatusExt.fromValue(json["status"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != -1) 'id': id,
      'title': title,
      'description': description,
      'status': status.value,
    };
  }

  @override
  List<Object?> get props => [id, title, description, status];
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

  String get text {
    switch (this) {
      case TaskStatus.done:
        return "Complete";
      case TaskStatus.notDone:
        return "Incomplete";
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
