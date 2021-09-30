import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('I See Multple Widgets pre-built step generated', () {
    const path = 'test';
    const featureFile = '''
Feature: Testing feature
    Scenario: Testing scenario
        Then I see multiple {SomeWidget} widgets
    ''';

    const expectedSteps = '''
import 'package:flutter_test/flutter_test.dart';

/// Example: Then I see multiple {SomeWidget} widgets
Future<void> iSeeMultipleWidgets(
  WidgetTester tester,
  Type type,
) async {
  expect(find.byType(type), findsWidgets);
}
''';

    final feature = FeatureFile(
        featureDir: '$path.feature', tablesFilename: '${path}_tables.dart', package: path, input: featureFile);

    expect(
      feature.getStepFiles().whereType<NewStepFile>().last.dartContent,
      expectedSteps,
    );
  });
}
