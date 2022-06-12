import 'module/di/di.dart';
import 'package:flutter/material.dart';

import 'module/task_cruid/task_cruid.dart';
import 'screen/home/home_screen.dart';

Future<void> setUpAndRunApp() async {
  setUpDI();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final taskMgmt = di<TaskCRUID>();
    await taskMgmt.prepareDb();
  } catch (e) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manabie interview',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomeScreen(),
    );
  }
}
