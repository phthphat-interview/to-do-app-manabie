import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_manabie/screen/home/bloc/home_bloc.dart';
import 'package:todo_manabie/screen/home/sub_screen/task_screen_type.dart';
import 'package:todo_manabie/view/view.dart';

import '../../../module/task_cruid/task_cruid.dart';

class TaskTypeScreen extends StatefulWidget {
  final TaskScreenType type;
  const TaskTypeScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<TaskTypeScreen> createState() => _TaskTypeScreenState();
}

class _TaskTypeScreenState extends State<TaskTypeScreen> with AutomaticKeepAliveClientMixin<TaskTypeScreen> {
  var _listKey = GlobalKey<AnimatedListState>();
  AnimatedListState? get _animatedList => _listKey.currentState;

  List<Task> _taskList = [];

  @override
  void initState() {
    super.initState();
    print("init state");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is TaskCreatedState) {
          if (widget.type == TaskScreenType.done) {
            return;
          }
          //only update for undone and all
          _taskList.insert(0, state.task);
          _animatedList?.insertItem(0);
        }
      },
      child: MinSizeStretchColumn(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${widget.type.tabName} task(s)",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              itemBuilder: (context, index, animation) {
                return Text(_taskList[index].title);
              },
              initialItemCount: _taskList.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
