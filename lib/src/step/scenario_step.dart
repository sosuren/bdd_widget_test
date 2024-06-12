
import 'package:bdd_widget_test/src/step/bdd_step.dart';

class ScenarioStep implements BddStep {

  ScenarioStep(this.methodName);

  final String methodName;

  @override
  String get content => '''
import 'package:flutter_test/flutter_test.dart';

Future<void> $methodName() async {
  /// mock here
  throw UnimplementedError();
}
''';

}
