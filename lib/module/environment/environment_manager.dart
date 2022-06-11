part './environment.dart';

Environment get env {
  return EnvironmentManager._env!;
}

class EnvironmentManager {
  static Environment? _env;

  static setEnvironment(Environment env) {
    assert(_env == null, "Environment can only be set once");
    _env = env;
  }
}
