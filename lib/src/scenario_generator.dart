import 'package:bdd_widget_test/src/bdd_line.dart';
import 'package:bdd_widget_test/src/step_data.dart';
import 'package:bdd_widget_test/src/step_generator.dart';
import 'package:bdd_widget_test/src/util/constants.dart';

void parseScenario(
  StringBuffer sb,
  String scenarioTitle,
  List<ScenarioTables> scenarioTables,
  List<BddLine> scenario,
  bool hasSetUp,
  bool hasTearDown,
  String testMethodName, {
    String? scenarioOutlineTitle,
  }
) {

  final hasTable = scenarioTables.any((t) => t.identifier == scenarioTitle.hashCode.toString());

  if (hasTable) {

    final scenarioTable = scenarioTables.firstWhere((t) => t.identifier == scenarioTitle.hashCode.toString());

    final inputLength = scenarioTable.tables.first.rows.length;
    if (inputLength > 1) {

      for (var i = 0; i < inputLength; i++) {
        _parseScenarioWithTable(sb, scenarioTitle, scenarioTables, scenario, hasSetUp, hasTearDown, testMethodName, atIndex: i, scenarioOutlineTitle: scenarioOutlineTitle);
      }
      return;
    }
  }

  _parseScenarioWithTable(sb, scenarioTitle, scenarioTables, scenario, hasSetUp, hasTearDown, testMethodName, scenarioOutlineTitle: scenarioOutlineTitle);
}

void _parseScenarioWithTable(
  StringBuffer sb,
  String scenarioTitle,
  List<ScenarioTables> scenarioTables,
  List<BddLine> scenario,
  bool hasSetUp,
  bool hasTearDown,
  String testMethodName, {
    int atIndex = 0,
    String? scenarioOutlineTitle,
  }
) {

  sb.writeln('    $testMethodName(\'\'\'${scenarioOutlineTitle ?? scenarioTitle}\'\'\', (tester) async {');
    if (hasSetUp) {
      sb.writeln('      await $setUpMethodName(tester);');
    }
    sb.writeln('      await ${getStepMethodName(scenarioTitle)}();');

    for (final step in scenario) {
      sb.writeln('      await ${getStepMethodCall(step.value, scenarioTitle: scenarioTitle, atIndex: atIndex)};');
    }

    if (hasTearDown) {
      sb.writeln('      await $tearDownMethodName(tester);');
    }

    sb.writeln('    });');
}

List<List<BddLine>> generateScenariosFromScenaioOutline(
  List<BddLine> scenario,
) {
  final examples = _getExamples(scenario);
  return examples
      .map((e) => _processScenarioLines(scenario, e).toList())
      .toList();
}

List<Map<String, String>> _getExamples(
  List<BddLine> scenario,
) {
  final exampleLines = scenario
      .where((l) => l.type == LineType.examples)
      .skip(1) // Skip 'Examples:` line
      .map((e) => e.rawLine.substring(
            // Remove the first and the last '|' separator
            1,
            e.rawLine.length - 2,
          ))
      .map(_parseExampleLine);
  final names = exampleLines.first;
  return exampleLines.skip(1).map((e) => Map.fromIterables(names, e)).toList();
}

List<String> _parseExampleLine(String line) =>
    line.split('|').map((e) => e.trim()).toList();

Iterable<BddLine> _processScenarioLines(
    List<BddLine> lines, Map<String, String> examples) sync* {
  final name = lines.first;
  yield BddLine.fromValue(
      name.type, '${name.value} (${examples.values.join(', ')})');

  for (final line in lines.skip(1).where((l) => l.type == LineType.step)) {
    yield BddLine.fromValue(
        line.type, _replacePlaceholders(line.value, examples));
  }
}

String _replacePlaceholders(String line, Map<String, String> example) {
  var replaced = line;
  for (final e in example.keys) {
    replaced = replaced.replaceAll(' <$e> ', ' {${example[e]}} ');
  }
  return replaced;
}
