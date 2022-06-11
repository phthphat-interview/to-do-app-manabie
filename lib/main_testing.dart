import 'package:todo_manabie/module/environment/environment_manager.dart';
import 'package:todo_manabie/my_app.dart';

Future<void> main() async {
  EnvironmentManager.setEnvironment(Environment.testing);
  await setUpAndRunApp();
}
