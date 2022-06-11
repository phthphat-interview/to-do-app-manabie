import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_manabie/screen/home/popup/task_creation_popup.dart';

import '../../../module/task_cruid/task_cruid.dart';
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
}

enum ViewTaskPurpose { create, edit }
