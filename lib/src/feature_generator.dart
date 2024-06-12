import 'package:bdd_widget_test/src/bdd_line.dart';
import 'package:bdd_widget_test/src/scenario_generator.dart';
import 'package:bdd_widget_test/src/step_data.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:bdd_widget_test/src/step_generator.dart';
import 'package:bdd_widget_test/src/util/constants.dart';

String generateTablesDart(List<ScenarioTables> scenarioTables) {

  final sb = StringBuffer();
  sb.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  sb.writeln();
  sb.writeln('import \'package:bdd_widget_test/bdd_widget_test.dart\';');
  sb.writeln();

  sb.writeln('final Map<String, Map<String, StepTable>> featureTables = {');

  for (final scenarioTable in scenarioTables) {
    sb.writeln(scenarioTable.dartContent);
  }

  sb.writeln('};');

  return sb.toString();
}

String generateFeatureDart(
  List<ScenarioTables> scenarioTables,
  List<BddLine> lines,
  List<StepFile> steps,
  String testMethodName,
  String tablesFilename,
  bool isIntegrationTest,
) {
  final sb = StringBuffer();
  sb.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  sb.writeln('// ignore_for_file: unused_import, directives_ordering');
  sb.writeln();
  sb.writeln('import \'package:flutter/material.dart\';');
  sb.writeln('import \'package:flutter_test/flutter_test.dart\';');
  if (isIntegrationTest) {
    sb.writeln('import \'package:integration_test/integration_test.dart\';');
  }
  sb.writeln();

  if (scenarioTables.isNotEmpty) {
    sb.writeln('import \'package:bdd_widget_test/bdd_widget_test.dart\';');
    sb.writeln();
    sb.writeln('import \'./$tablesFilename\';');
    sb.writeln();
  }

  var featureTestMethodNameOverride = testMethodName;

  for (final line
      in lines.takeWhile((value) => value.type != LineType.feature)) {
    if (line.type == LineType.tag) {
      final methodName = _parseTestMethodNameTag(line.rawLine);
      if (methodName.isNotEmpty) {
        featureTestMethodNameOverride = methodName;
      }
    } else {
      sb.writeln(line.rawLine);
    }
  }

  for (final step in steps.map((e) => e.import).toSet()) {
    sb.writeln('import \'$step\';');
  }

  sb.writeln();
  sb.writeln('void main() {');
  if (isIntegrationTest) {
    sb.writeln('  IntegrationTestWidgetsFlutterBinding.ensureInitialized();');
    sb.writeln();
  }

  final features = splitWhen<BddLine>(
      lines.skipWhile((value) => value.type != LineType.feature), // skip header
      (e) => e.type == LineType.feature);

  for (final feature in features) {
    final hasBackground = _parseBackground(sb, feature);
    final hasAfter = _parseAfter(sb, feature);

    _parseFeature(
      sb,
      scenarioTables,
      feature,
      hasBackground,
      hasAfter,
      featureTestMethodNameOverride,
    );
  }
  sb.writeln('}');
  return sb.toString();
}

bool _parseBackground(StringBuffer sb, List<BddLine> lines) =>
    _parseSetup(sb, lines, LineType.background, setUpMethodName);

bool _parseAfter(StringBuffer sb, List<BddLine> lines) =>
    _parseSetup(sb, lines, LineType.after, tearDownMethodName);

bool _parseSetup(
    StringBuffer sb, List<BddLine> lines, LineType elementType, String title) {
  var offset = lines.indexWhere((element) => element.type == elementType);
  if (offset != -1) {
    sb.writeln('  Future<void> $title(WidgetTester tester) async {');
    offset++;
    while (lines[offset].type == LineType.step) {
      sb.writeln('    await ${getStepMethodCall(lines[offset].value)};');
      offset++;
    }
    sb.writeln('  }');
  }
  return offset != -1;
}

void _parseFeature(
  StringBuffer sb,
  List<ScenarioTables> scenarioTables,
  List<BddLine> feature,
  bool hasSetUp,
  bool hasTearDown,
  String testMethodName,
) {
  sb.writeln('  group(\'\'\'${feature.first.value}\'\'\', () {');

  final scenarios = splitWhen<BddLine>(
    feature.skipWhile((e) => !_isScenarioKindLine(e.type)),
    (e) => _isScenarioKindLine(e.type),
  ).toList();
  for (final scenario in scenarios) {
    final scenarioTestMethodName =
        _parseScenaioTags(feature, scenario.first, testMethodName);
    if (scenario.first.type == LineType.scenario) {
      parseScenario(
        sb,
        scenario.first.value,
        scenarioTables,
        scenario.where((e) => e.type == LineType.step).toList(),
        hasSetUp,
        hasTearDown,
        scenarioTestMethodName,
      );
    } else {
      final generatedScenarios = generateScenariosFromScenaioOutline(scenario);
      for (final g in generatedScenarios) {
        parseScenario(
          sb,
          scenario.first.value,
          scenarioTables,
          g.where((e) => e.type == LineType.step).toList(),
          hasSetUp,
          hasTearDown,
          scenarioTestMethodName,
          scenarioOutlineTitle: g.first.value,
        );
      }
    }
  }
  sb.writeln('  });');
}

bool _isScenarioKindLine(LineType type) =>
    type == LineType.scenario || type == LineType.scenarioOutline;

String _parseScenaioTags(
  List<BddLine> feature,
  BddLine scenario,
  String testMethodName,
) {
  var scenarioTestMethodName = testMethodName;
  final prevLine = feature[feature.indexOf(scenario) - 1];
  if (prevLine.type == LineType.tag) {
    final testMethodNameOverride = _parseTestMethodNameTag(prevLine.rawLine);
    if (testMethodNameOverride.isNotEmpty) {
      scenarioTestMethodName = testMethodNameOverride;
    }
  }
  return scenarioTestMethodName;
}

String _parseTestMethodNameTag(String rawLine) {
  const tag = '@testMethodName:';
  if (rawLine.startsWith(tag)) {
    return rawLine.substring(tag.length).trim();
  }
  return '';
}

List<List<T>> splitWhen<T>(Iterable<T> original, bool Function(T) predicate) =>
    original.fold(<List<T>>[], (previousValue, element) {
      if (predicate(element)) {
        previousValue.add([element]);
      } else {
        previousValue.last.add(element);
      }
      return previousValue;
    });
