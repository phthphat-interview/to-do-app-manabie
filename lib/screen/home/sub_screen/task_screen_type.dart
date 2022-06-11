import 'package:flutter/material.dart';

enum TaskScreenType { all, done, notDone }

extension TaskScreenTypeExt on TaskScreenType {
  String get tabName {
    switch (this) {
      case TaskScreenType.all:
        return 'All';
      case TaskScreenType.done:
        return 'Completed';
      case TaskScreenType.notDone:
        return 'Incompleted';
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
