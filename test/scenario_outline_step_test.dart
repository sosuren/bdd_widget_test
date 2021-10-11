import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Scenario Outline Step', () {
    const featureFile = '''
Feature: Testing feature
  Scenario Outline: eating
    Given there are <start> cucumbers

    Examples:
      | start |
      |    12 |
      |    20 |
''';

    const outlineStep = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> outlineEating() async {
  /// mock here
  throw UnimplementedError();
}
''';
    const expectedStep = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> thereAreCucumbers(WidgetTester tester, dynamic param1) async {
  throw UnimplementedError();
}
''';

    final feature = FeatureFile(
      featureDir: 'test.feature',
      package: 'test',
      input: featureFile,
      tablesFilename: 'test_tables.dart',
    );

    expect(
      feature.getStepFiles().whereType<NewStepFile>().length,
      2,
    );
    expect(
      feature.getStepFiles().whereType<NewStepFile>().first.dartContent,
      outlineStep,
    );
    expect(
      feature.getStepFiles().whereType<NewStepFile>().last.dartContent,
      expectedStep,
    );
  });
}
