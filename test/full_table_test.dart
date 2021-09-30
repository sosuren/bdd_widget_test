import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:bdd_widget_test/src/step_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('table input and output test ', () {

    const scenarioName = 'Testing scenario';
    const dataInputStep = 'I input these data in register form';
    const dataResultStep = 'I should see these results in attendance table';
    const featureFile = '''
Feature: Testing feature
    Scenario: $scenarioName
        Given I am in the register form
        When $dataInputStep
          |  Username  |   IsPresent |
          |  someuser  |     yes     |
          |  otheruser |     no      |
        Then $dataResultStep
          |  Username  |   IsPresent |
          |  someuser  |     yes     |
          |  otheruser |     no      |
''';

    final expectedFeatureDart = '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bdd_widget_test/bdd_widget_test.dart';

import './test_tables.dart';

import './step/testing_scenario.dart';
import './step/i_am_in_the_register_form.dart';
import './step/i_input_these_data_in_register_form.dart';
import './step/i_should_see_these_results_in_attendance_table.dart';

void main() {
  group('Testing feature', () {
    testWidgets('$scenarioName', (tester) async {
      await testingScenario();
      await iAmInTheRegisterForm(tester);
      await iInputTheseDataInRegisterForm(tester, featureTables['${scenarioName.hashCode}']!['${getStepMethodName(dataInputStep).hashCode}']!.copyWithRow(0));
      await iShouldSeeTheseResultsInAttendanceTable(tester, featureTables['${scenarioName.hashCode}']!['${getStepMethodName(dataResultStep).hashCode}']!.copyWithRow(0));
    });
    testWidgets('Testing scenario', (tester) async {
      await testingScenario();
      await iAmInTheRegisterForm(tester);
      await iInputTheseDataInRegisterForm(tester, featureTables['${scenarioName.hashCode}']!['${getStepMethodName(dataInputStep).hashCode}']!.copyWithRow(1));
      await iShouldSeeTheseResultsInAttendanceTable(tester, featureTables['${scenarioName.hashCode}']!['${getStepMethodName(dataResultStep).hashCode}']!.copyWithRow(1));
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
