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
    this.existingSteps = const <String, String>{},
    this.generatorOptions = const GeneratorOptions(),
  }) : scenarioTables = getScenarioTables(input), _lines = _prepareLines(input
            .split('\n')
            .map((line) => line.trim())
            .map((line) => BddLine(line))) {
    _stepFiles = _lines
        .where((line) => line.type == LineType.step)
        .map((e) => StepFile.create(
              featureDir,
              package,
              e.value,
              existingSteps,
              generatorOptions,
            ))
        .toList();
  }


  late List<StepFile> _stepFiles;

  final String featureDir;
  final String package;
  final String tablesFilename;
  final List<ScenarioTables> scenarioTables;
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
  static final RegExp dataTableMatcher = RegExp(r'(?<=((.*)[\r\n]))(\|.*\|[\r\n])+');

  static List<ScenarioTables> getScenarioTables(String input) {

    final scenarioTables = <ScenarioTables>[];

    // clean up
    final content = '${_sanitizeFeatureContent(input)}\n\n'; // add extra lines for scenarios at the end

    // list the scenarios
    final allMatchedScenarios = scenarioMatcher.allMatches(content);

    for (final scenarioMatch in allMatchedScenarios) {

      final scenarioGroup = scenarioMatch.group(0);

      if (scenarioGroup != null) {

        final scenarioContent = '$scenarioGroup\n'; // add one line break to match tables at the end

        final allMatchedDataSteps = dataStepMatcher.allMatches(scenarioContent).toList();
        final allMatchedDataTables = dataTableMatcher.allMatches(scenarioContent).toList();

        if (allMatchedDataSteps.length != allMatchedDataTables.length) {
          throw Exception('Mising data table for some steps');
        }

        final stepTables = <StepTable>[];

        for (var i = 0; i < allMatchedDataSteps.length; i++) {

          final thisMatchedDataStep = allMatchedDataSteps[i];
          final thisMatchedDataTable = allMatchedDataTables[i];

          // read step definition only
          final stepMethodName = getStepMethodName(
            removeLinePrefix(thisMatchedDataStep.group(0)!),
          );

          final stepTable = _buildTableFromTableContent(stepMethodName, thisMatchedDataTable.group(0)!);
          stepTables.add(stepTable);
        }

        final scenarioName = scenarioGroup
          .split('\n')
          .map((line) => BddLine(line))
          .firstWhere((bddLine) => bddLine.type == LineType.scenario)
          .value;

        if (stepTables.isNotEmpty) {

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
  
  static StepTable _buildTableFromTableContent(String stepName, String tableContent) {

    final rows = tableContent.split('\n').where((line) => line.trim().isNotEmpty).toList();

    final headerRow = rows.first;
    final header = StepTableHeader(
      names: _trimTablePipes(headerRow)
        .split('|')
        .map((e) => e.trim())
        .toList(),
    );

    rows.removeAt(0);
    final values = <StepTableRow>[];
    for (final valueRow in rows) {

      values.add(
        StepTableRow(
          values: _trimTablePipes(valueRow)
            .split('|')
            .map((e) => e.trim())
            .toList(),
        ),
      );
    }

    return StepTable(identifier: stepName.hashCode.toString(), header: header, rows: values);
  }

  static String _trimTablePipes(String rowContent) => rowContent
    .replaceAll(RegExp(r'^\|'), '')
    .replaceAll(RegExp(r'\|$'), '');
}
