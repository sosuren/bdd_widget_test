import 'package:bdd_widget_test/src/bdd_line.dart';
import 'package:bdd_widget_test/src/feature_generator.dart';
import 'package:bdd_widget_test/src/generator_options.dart';
import 'package:bdd_widget_test/src/step_data.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:bdd_widget_test/src/step_generator.dart';

class FeatureFile {
  FeatureFile({
    required this.featureDir,
    required this.package,
    required this.tablesFilename,
    required String input,
    this.isIntegrationTest = false,
    this.existingSteps = const <String, String>{},
    this.generatorOptions = const GeneratorOptions(),
  }) : scenarioTables = getScenarioTables(input), _lines = _prepareLines(input
            .split('\n')
            .map((line) => line.trim())
            .map((line) => BddLine(line))) {
    _stepFiles = _lines
        .where((line) => [LineType.step, LineType.scenario].contains(line.type))
        .map((e) => StepFile.create(
              featureDir,
              package,
              e.value,
              existingSteps,
              generatorOptions,
              e.type == LineType.scenario,
            ))
        .toList();
  }


  late List<StepFile> _stepFiles;

  final String featureDir;
  final String package;
  final String tablesFilename;
  final List<ScenarioTables> scenarioTables;
  final bool isIntegrationTest;
  final List<BddLine> _lines;
  final Map<String, String> existingSteps;
  final GeneratorOptions generatorOptions;

  String get tableContent => generateTablesDart(scenarioTables);

  String get dartContent => generateFeatureDart(
        scenarioTables,
        _lines,
        getStepFiles(),
        generatorOptions.testMethodName,
        tablesFilename,
        isIntegrationTest,
      );

  List<StepFile> getStepFiles() => _stepFiles;

  static List<BddLine> _prepareLines(Iterable<BddLine> input) {
    final headers = input.takeWhile((value) => value.type == LineType.unknown);
    final lines = input
        .skip(headers.length)
        .where((value) => value.type != LineType.unknown);
    return [...headers, ...lines];
  }

  static final RegExp featureBlockMatcher = RegExp(r'Feature:[\s\S]*?(?=[\r?\n]{2})');
  static final RegExp backgroundBlockMatcher = RegExp(r'Background:[\s\S]*?(?=[\r?\n]{2})');
  static final RegExp afterStepBlockMatcher = RegExp(r'After:[\s\S]*?(?=[\r?\n]{2})');
  static final RegExp scenarioMatcher = RegExp(r'Scenario:[\s\S]*?(?=[\r?\n]{2})');
  static final RegExp dataStepMatcher = RegExp(r'.*((these data)|(see these results)).*');
   // referred from: https://github.com/jonsamwell/dart_gherkin/blob/803b5fc1a16b00093123eca5aeea70affa259e50/lib/src/gherkin/syntax/table_line_syntax.dart#L11
  static final RegExp tableLineMatcher = RegExp(
    r'^\s*(\|.*\|)\s*(?:\s*#\s*.*)?$',
    caseSensitive: false,
  );

  static List<ScenarioTables> getScenarioTables(String input) {

    final scenarioTables = <ScenarioTables>[];

    // clean up
    final content = '${_sanitizeFeatureContent(input)}\n\n'; // add extra lines for scenarios at the end

    // list the scenarios
    final allMatchedScenarios = scenarioMatcher.allMatches(content);

    for (final scenarioMatch in allMatchedScenarios) {

      final scenarioGroup = scenarioMatch.group(0);

      if (scenarioGroup != null) {

        final scenarioContent = '$scenarioGroup\n\n'; // add one line break to match tables at the end

        final allMatchedDataSteps = dataStepMatcher.allMatches(scenarioContent).toList();

        if (allMatchedDataSteps.isEmpty) {
          continue;
        }

        final stepTables = _parseStepTables(scenarioContent);

        if (allMatchedDataSteps.length != stepTables.length) {
          throw Exception('Missing data table for data step.\n\tNumber of data step: ${allMatchedDataSteps.length}\n\tNumber of tables; {stepTables.length}');
        }

        if (stepTables.isNotEmpty) {

          final scenarioName = scenarioGroup
            .split('\n')
            .map((line) => BddLine(line))
            .firstWhere((bddLine) => bddLine.type == LineType.scenario)
            .value;

          final scenarioTable = ScenarioTables(
            identifier: scenarioName.hashCode.toString(),
            tables: stepTables,
          );
          scenarioTables.add(
            scenarioTable,
          );
        }
      }
    }

    return scenarioTables;
  }

  static String _sanitizeFeatureContent(String featureContent) => featureContent
    .split(RegExp(r'\r?\n')) // splits into lines. matches carriage return in unix, linux and windows
    .map((line) => line.trim()) // removes extra spaces at both end of each line
    .map((line) => line.startsWith('#') ? '' : line) // line comments are replaced with empty string
    .join('\n'); // re join each line by line break

  static List<StepTable> _parseStepTables(String scenarioContent) {

    final stepTables = <StepTable>[];
    StepTable? stepTable;

    final stepLines = scenarioContent.split('\n').toList();

    for (var i = 0; i < stepLines.length; i++) {

      final thisLine = stepLines[i];

      final isTableLine = tableLineMatcher.hasMatch(thisLine);

      if (!isTableLine) {

        if (stepTable != null) {
          stepTables.add(stepTable);
          stepTable = null;
        }
        continue;
      }

      if (stepTable == null) { // table row started

        final previousLine = stepLines[i - 1];
        final stepMethodName = getStepMethodName(
          removeLinePrefix(previousLine),
        );
        stepTable = StepTable(
          identifier: stepMethodName.hashCode.toString(),
          header: StepTableHeader(names: _getRowValues(thisLine)),
          rows: []
        );

      } else { // is table row

        stepTable = StepTable(
          identifier: stepTable.identifier,
          header: stepTable.header,
          rows: List.from(stepTable.rows)..add(
            StepTableRow(values: _getRowValues(thisLine)),
          ),
        );
      }
    }

    return stepTables;
  }

  static List<String> _getRowValues(String row) => _trimTablePipes(row)
        .split('|')
        .map((e) => e.trim())
        .toList();

  static String _trimTablePipes(String rowContent) => rowContent
    .replaceAll(RegExp(r'^\|'), '')
    .replaceAll(RegExp(r'\|$'), '');
}
