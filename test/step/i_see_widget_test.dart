import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('I See Widget pre-built step generated', () {
    const path = 'test';
    const featureFile = '''
Feature: Testing feature
    Scenario: Testing scenario
        When I see {SomeWidget} widget
    ''';

    const expectedSteps = '''
import 'package:flutter_test/flutter_test.dart';

/// Example: Then I see {SomeWidget} widget
Future<void> iSeeWidget(
  WidgetTester tester,
  Type type,
) async {
  expect(find.byType(type), findsOneWidget);
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
