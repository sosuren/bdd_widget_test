import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('After steps appear after groups ', () {
    const featureFile = '''
Feature: Testing feature
  After:
    And the test finishes
  Scenario: Testing scenario
    Given the app is running
''';

    const expectedFeatureDart = '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_test_finishes.dart';
import './step/testing_scenario.dart';
import './step/the_app_is_running.dart';

void main() {
  Future<void> bddTearDown(WidgetTester tester) async {
    await theTestFinishes(tester);
  }
  group(\'\'\'Testing feature\'\'\', () {
    testWidgets(\'\'\'Testing scenario\'\'\', (tester) async {
      await testingScenario();
      await theAppIsRunning(tester);
      await bddTearDown(tester);
    });
  });
}
''';

    final feature = FeatureFile(
      featureDir: 'test.feature',
      tablesFilename: 'test_tables.dart',
      package: 'test',
      input: featureFile,
    );
    expect(feature.dartContent, expectedFeatureDart);
  });
}
