import 'package:flutter/material.dart';
import 'package:todo_manabie/module/task_cruid/task_cruid.dart';
import 'package:todo_manabie/screen/home/home_screen.dart';

import 'module/di/di.dart';

void main() async {
  setUpDI();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final taskMgmt = di<TaskCRUID>();
    await taskMgmt.prepareDb();
    // await taskMgmt.create(Task(title: "Ahihi"));
    // taskMgmt.count().then((value) => print("Task count: $value"));
    (await taskMgmt.getAll()).forEach((element) {
      print(element.toJson());
    });
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manabie interview',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
