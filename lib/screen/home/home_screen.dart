import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_manabie/screen/about_me/about_me.dart';
import 'package:todo_manabie/screen/home/popup/home_popup.dart';
import 'package:todo_manabie/screen/home/sub_screen/task_screen_type.dart';
import 'package:todo_manabie/screen/home/sub_screen/task_type_screen.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomeMainView(),
    );
  }
}

class _HomeMainView extends StatefulWidget {
  const _HomeMainView({Key? key}) : super(key: key);

  @override
  State<_HomeMainView> createState() => __HomeMainViewState();
}

class __HomeMainViewState extends State<_HomeMainView> {
  final ValueNotifier<TaskScreenType> _currentTab = ValueNotifier(TaskScreenType.notDone);
  final _allTabs = [TaskScreenType.notDone, TaskScreenType.done, TaskScreenType.all];

  final _pageController = PageController(initialPage: 0);

  void _onPressCreate() async {
    final task = await HomePopup.showTaskPopup(context, ViewTaskPurpose.create);
    if (task != null) {
      _bloc.add(CreateTaskEvent(task));
    }
  }

  late final _bloc = BlocProvider.of<HomeBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeShowBottomMessageState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("To do list"),
          actions: [
            IconButton(onPressed: _onPressCreate, icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutMe()));
                },
                icon: const Icon(Icons.person)),
          ],
        ),
        body: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) => TaskTypeScreen(type: _allTabs[index]),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allTabs.length,
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder<TaskScreenType>(
          valueListenable: _currentTab,
          builder: (context, type, child) {
            return BottomNavigationBar(
              currentIndex: type.tabOrdinal,
              onTap: (index) {
                _currentTab.value = _allTabs[index];
                _pageController.jumpToPage(index);
              },
              items: _allTabs
                  .map(
                    (e) => BottomNavigationBarItem(icon: e.tabIcon, label: e.tabName),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
