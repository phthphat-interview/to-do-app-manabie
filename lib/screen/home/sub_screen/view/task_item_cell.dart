import 'package:flutter/material.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';

class TaskItemCell extends StatelessWidget {
  final Task task;
  const TaskItemCell({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(task.title);
  }
}
