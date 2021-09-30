import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Generic step generated', () {
    const path = 'test';
    const featureFile = '''
Feature: Testing feature
    Scenario: Testing scenario
        When I invoke test
    ''';

    const expectedScenarioStep = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> testingScenario() async {
  /// mock here
  throw UnimplementedError();
}
''';

    const expectedSteps = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> iInvokeTest(WidgetTester tester) async {
  throw UnimplementedError();
}
''';

    final feature = FeatureFile(
        featureDir: '$path.feature', tablesFilename: '${path}_tables.dart', package: path, input: featureFile);

    expect(feature.getStepFiles().whereType<NewStepFile>().length == 2, isTrue);

    expect(
      feature.getStepFiles().whereType<NewStepFile>().first.dartContent,
      expectedScenarioStep,
    );

    expect(
      feature.getStepFiles().whereType<NewStepFile>().last.dartContent,
      expectedSteps,
    );
  });

  test('Generic step with parameters generated', () {
    const path = 'test';
    const featureFile = '''
Feature: Testing feature
    Scenario: Testing scenario
        When I invoke {0} test with {Some} parameter
    ''';

    const expectedScenarioStep = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> testingScenario() async {
  /// mock here
  throw UnimplementedError();
}
''';

    const expectedSteps = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> iInvokeTestWithParameter(WidgetTester tester, dynamic param1, dynamic param2) async {
  throw UnimplementedError();
}
''';

    final feature = FeatureFile(
        featureDir: '$path.feature', tablesFilename: '${path}_tables.feature',package: path, input: featureFile);

    expect(feature.getStepFiles().whereType<NewStepFile>().length == 2, isTrue);

    expect(
      feature.getStepFiles().whereType<NewStepFile>().first.dartContent,
      expectedScenarioStep,
    );

    expect(
      feature.getStepFiles().whereType<NewStepFile>().last.dartContent,
      expectedSteps,
    );
  });

  test('Special characters ignored', () {
    const path = 'test';
    const featureFile = '''
Feature: Testing feature
    Scenario: [asd-ddf12*] [(dfd)] Testing scenario (adsf)
        When !  I@ #invoke\$%   ^'`~  &*+=) test ?   &&/| \\ ;:
    ''';

    const expectedScenarioStep = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> asdddf12DfdTestingScenarioAdsf() async {
  /// mock here
  throw UnimplementedError();
}
''';

    const expectedSteps = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> iInvokeTest(WidgetTester tester) async {
  throw UnimplementedError();
}
''';

    final feature = FeatureFile(
        featureDir: '$path.feature', tablesFilename: '${path}_tables.feature', package: path, input: featureFile);

    expect(feature.getStepFiles().whereType<NewStepFile>().length == 2, isTrue);

    expect(
      feature.getStepFiles().whereType<NewStepFile>().first.dartContent,
      expectedScenarioStep,
    );

    expect(
      feature.getStepFiles().whereType<NewStepFile>().last.dartContent,
      expectedSteps,
    );
  });

  test('Testing Table Steps', () {
    const path = 'test';
    const featureFile = '''
Feature: Testing feature
    Scenario: Testing scenario
        Given I am in the register form
        When I input these data in register form
          |  Username  |   IsPresent |
          |  someuser  |     yes     |
          |  otheruser |     no      |
        Then I should see these results in attendance table
          |  Username  |   IsPresent |
          |  someuser  |     yes     |
          |  otheruser |     no      |
    ''';

    const expectedScenarioStep = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> testingScenario() async {
  /// mock here
  throw UnimplementedError();
}
''';

    const expectedStep1 = '''
import 'package:flutter_test/flutter_test.dart';

Future<void> iAmInTheRegisterForm(WidgetTester tester) async {
  throw UnimplementedError();
}
''';

    const expectedStep2 = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:bdd_widget_test/bdd_widget_test.dart';

Future<void> iInputTheseDataInRegisterForm(WidgetTester tester, StepTable table) async {
  throw UnimplementedError();
}
''';

    const expectedStep3 = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:bdd_widget_test/bdd_widget_test.dart';

Future<void> iShouldSeeTheseResultsInAttendanceTable(WidgetTester tester, StepTable table) async {
  throw UnimplementedError();
}
''';

    final feature = FeatureFile(
        featureDir: '$path.feature', tablesFilename: '${path}_tables.feature', package: path, input: featureFile);

    expect(feature.getStepFiles().whereType<NewStepFile>().length, 4);

    expect(
      feature.getStepFiles().whereType<NewStepFile>().first.dartContent,
      expectedScenarioStep,
    );

    expect(
      feature.getStepFiles().whereType<NewStepFile>().toList()[1].dartContent,
      expectedStep1,
    );
    expect(
      feature.getStepFiles().whereType<NewStepFile>().toList()[2].dartContent,
      expectedStep2,
    );
    expect(
      feature.getStepFiles().whereType<NewStepFile>().toList()[3].dartContent,
      expectedStep3,
    );
  });
}
