import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_manabie/screen/home/bloc/home_bloc.dart';
import 'package:todo_manabie/screen/home/popup/home_popup.dart';
import 'package:todo_manabie/screen/home/sub_screen/task_screen_type.dart';
import 'package:todo_manabie/screen/home/sub_screen/view/task_item_cell.dart';
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
  final ValueNotifier<bool> _isListEmpty = ValueNotifier(true);

  late final _bloc = BlocProvider.of<HomeBloc>(context);

  @override
  void initState() {
    super.initState();
    _bloc.getTaskList(widget.type).then((value) {
      _taskList = value;
      for (var _ in _taskList) {
        _animatedList?.insertItem(0);
      }
      _triggerIsEmptyList();
    });
  }

  void _triggerIsEmptyList() {
    _isListEmpty.value = _taskList.isEmpty;
  }

  void _onToggleCheckBox(Task task) async {
    final isConfirm = await HomePopup.confirmChangeTaskStatus(context, task.status);
    if (isConfirm == true) _bloc.add(TaskTypeChangeEvent(task));
  }

  void _onReceiveTaskChangeState(TaskTypeChangeState state) {
    final index = _taskList.indexWhere((task) => task.id == state.task.id);
    if (widget.type == TaskScreenType.all) {
      //update ui if here is all

      if (index != -1) {
        _taskList.removeAt(index);
        _animatedList?.removeItem(index, (context, animation) => SizedBox());
        _taskList.insert(0, state.task);
        _animatedList?.insertItem(0);
      }
      _triggerIsEmptyList();
      return;
    }
    if (widget.type.taskStatus != state.task.status) {
      //status change from here to other
      if (index != -1) {
        _taskList.removeAt(index);
        _animatedList?.removeItem(index, (context, animation) => _buildRemove(animation, state.task));
      }
    }
    if (widget.type.taskStatus == state.task.status) {
      //status change from other to here
      _taskList.insert(0, state.task);
      _animatedList?.insertItem(0);
    }
    _triggerIsEmptyList();
  }

  Widget _buildRemove(Animation<double> animation, Task task) {
    return FadeTransition(opacity: animation, child: TaskItemCell(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is TaskCreatedState) {
          if (widget.type == TaskScreenType.done) {
            return;
          }
          //only update for undone and all
          _taskList.insert(0, state.task);
          _animatedList?.insertItem(0);
        }
        if (state is TaskTypeChangeState) {
          _onReceiveTaskChangeState(state);
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
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedList(
                  key: _listKey,
                  itemBuilder: (context, index, animation) {
                    return TaskItemCell(
                      task: _taskList[index],
                      onToggleCheckBox: () {
                        _onToggleCheckBox(_taskList[index]);
                      },
                    );
                  },
                  initialItemCount: _taskList.length,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isListEmpty,
                  builder: (context, isEmpty, child) {
                    return Visibility(visible: isEmpty, child: child!);
                  },
                  child: MinSizeStretchColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.airline_seat_individual_suite_rounded, size: 50),
                      SizedBox(height: 10),
                      Text("There are no task here"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
