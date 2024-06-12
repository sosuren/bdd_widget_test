import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('I See Disabled Elevated Button pre-built step generated', () {
    const path = 'test';
    const featureFile = '''
Feature: Testing feature
    Scenario: Testing scenario
        When I see disabled elevated button
    ''';

    const expectedSteps = '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Example: Then I see disabled elevated button
Future<void> iSeeDisabledElevatedButton(
  WidgetTester tester,
) async {
  final button = find.byType(ElevatedButton);

  expect((tester.firstWidget(button) as ElevatedButton).enabled, false);
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
