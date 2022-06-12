import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_manabie/screen/home/popup/task_creation_popup.dart';

import '../../../module/task_cruid/task_cruid.dart';
import '../../../view/view.dart';
import '../bloc/home_bloc.dart';

abstract class HomePopup {
  static Future<Task?> showTaskPopup(BuildContext context, ViewTaskPurpose purpose, {Task? editTask}) {
    if (purpose == ViewTaskPurpose.edit && editTask == null) {
      throw Exception("editTask is null");
    }
    final _bloc = BlocProvider.of<HomeBloc>(context);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: BlocProvider.value(
              value: _bloc,
              child: TaskCreationPopUp(
                purpose: purpose,
                editTask: editTask,
              ),
            ),
          );
        });
  }

  ///statusToChange is original status, if it is notDone mean this confirm popup ask people to change from notDone to done
  static Future<bool?> confirmChangeTaskStatus(BuildContext context, TaskStatus statusToChange) {
    final destinationStatus = statusToChange == TaskStatus.notDone ? TaskStatus.done : TaskStatus.notDone;
    return showDialog<bool>(
        context: context,
        builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MinSizeStretchColumn(
                  children: [
                    Text(
                      "Confirm",
                      style:
                          TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text("Are you sure to change task status to ${destinationStatus.text}?"),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            child: Text("Cancel"),
                            style: ElevatedButton.styleFrom(primary: Colors.black26),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}

enum ViewTaskPurpose { create, edit }
