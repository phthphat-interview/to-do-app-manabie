part of './environment_manager.dart';

enum Environment {
  development,
  testing
  // production,
}

extension EnvironmentExt on Environment {
  bool get isTesting {
    return this == Environment.testing;
  }
}
