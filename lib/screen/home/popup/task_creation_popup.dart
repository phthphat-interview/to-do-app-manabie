import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_manabie/module/app_error/simple_error.dart';

import '../../../module/task_cruid/task_cruid.dart';
import '../../../view/view.dart';
import '../bloc/home_bloc.dart';
import 'home_popup.dart';

class TaskCreationPopUp extends StatefulWidget {
  final ViewTaskPurpose purpose;
  final Task? editTask;
  const TaskCreationPopUp({Key? key, required this.purpose, this.editTask}) : super(key: key);

  @override
  State<TaskCreationPopUp> createState() => _TaskCreationPopUpState();
}

class _TaskCreationPopUpState extends State<TaskCreationPopUp> {
  final _errText = ValueNotifier<String?>(null);

  var _title = "";
  var _desc = "";

  late var _bloc = BlocProvider.of<HomeBloc>(context);

  void _onPressConfirm() {
    try {
      final task = _bloc.createTask(_title, _desc);
      Navigator.of(context).pop(task);
    } on SimpleError catch (e) {
      _errText.value = e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_bloc);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MinSizeStretchColumn(
        children: [
          Text(
            widget.purpose == ViewTaskPurpose.create ? "Task creation" : "Task edit",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          TextField(
            autofocus: widget.purpose == ViewTaskPurpose.create,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
            style: const TextStyle(fontSize: 18),
            onChanged: (txt) => _title = txt,
            // controller: TextEditingController(text: widget.editTask?.title ?? ""),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Description",
            ),
            style: const TextStyle(fontSize: 18),
            onChanged: (txt) => _desc = txt,
            // controller: TextEditingController(text: widget.editTask?.title ?? ""),
          ),
          ValueListenableBuilder<String?>(
              valueListenable: _errText,
              builder: (context, errText, _) {
                if (errText == null) {
                  return const SizedBox();
                }
                return MinSizeStretchColumn(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      errText,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                  ],
                );
              }),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MinSizeStretchColumn(
              children: [
                ElevatedButton(onPressed: _onPressConfirm, child: Text("OK")),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black26,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
