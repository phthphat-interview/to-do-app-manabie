import 'package:flutter/material.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';

enum TaskScreenType { all, done, notDone }

extension TaskScreenTypeExt on TaskScreenType {
  TaskStatus? get taskStatus {
    switch (this) {
      case TaskScreenType.all:
        return null;
      case TaskScreenType.notDone:
        return TaskStatus.notDone;
      case TaskScreenType.done:
        return TaskStatus.done;
    }
  }

  String get tabName {
    switch (this) {
      case TaskScreenType.all:
        return 'All';
      case TaskScreenType.done:
        return 'Completed';
      case TaskScreenType.notDone:
        return 'Incomplete';
    }
  }

  Icon get tabIcon {
    switch (this) {
      case TaskScreenType.all:
        return Icon(Icons.list);
      case TaskScreenType.done:
        return Icon(Icons.done);
      case TaskScreenType.notDone:
        return Icon(Icons.incomplete_circle);
    }
  }

  int get tabOrdinal {
    switch (this) {
      case TaskScreenType.notDone:
        return 0;
      case TaskScreenType.done:
        return 1;
      case TaskScreenType.all:
        return 2;
    }
  }
}
