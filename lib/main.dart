import 'package:todo_manabie/module/environment/environment_manager.dart';
import 'package:todo_manabie/my_app.dart';

void main() async {
  EnvironmentManager.setEnvironment(Environment.development);
  setUpAndRunApp();
}
