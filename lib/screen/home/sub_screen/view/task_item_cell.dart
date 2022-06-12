import 'package:flutter/material.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';

import '../../../../view/view.dart';

class TaskItemCell extends StatelessWidget {
  final Task task;
  final void Function()? onToggleCheckBox;
  const TaskItemCell({Key? key, required this.task, this.onToggleCheckBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: MinSizeStretchColumn(
        children: [
          Row(
            children: [
              Expanded(
                  child: MinSizeStretchColumn(
                children: [
                  Text(task.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  if (task.description != null) Text(task.description!),
                ],
              )),
              const SizedBox(width: 10),
              Text("Complete: "),
              IconButton(
                  onPressed: () {
                    onToggleCheckBox?.call();
                  },
                  icon: Icon(
                    task.status == TaskStatus.done ? Icons.check_box : Icons.check_box_outline_blank,
                    color: task.status == TaskStatus.done ? Theme.of(context).primaryColor : null,
                  )),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
