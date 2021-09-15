import 'dart:io';

import 'package:bdd_widget_test/src/existing_steps.dart';
import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:bdd_widget_test/src/generator_options.dart';
import 'package:bdd_widget_test/src/step_file.dart';
import 'package:bdd_widget_test/src/step_generator.dart';
import 'package:build/build.dart';

import 'package:path/path.dart' as p;

export 'package:bdd_widget_test/src/step_data.dart';

Builder featureBuilder(BuilderOptions options) => FeatureBuilder(
      GeneratorOptions.fromMap(options.config),
    );

class FeatureBuilder implements Builder {
  FeatureBuilder(this.generatorOptions);

  final GeneratorOptions generatorOptions;

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final contents = await buildStep.readAsString(inputId);

    final featureDir = p.dirname(inputId.path);
    final tablesFileName = getTablesFilename(featureDir, inputId.path);
    final feature = FeatureFile(
      featureDir: featureDir,
      package: inputId.package,
      tablesFilename: tablesFileName,
      existingSteps:
          getExistingStepSubfolders(featureDir, generatorOptions.stepFolder),
      input: contents,
      generatorOptions: generatorOptions,
    );

    final featureDart = inputId.changeExtension('_test.dart');
    await buildStep.writeAsString(featureDart, feature.dartContent);

    if (feature.scenarioTables.isNotEmpty) {
      
      final f = File(p.join(featureDir, tablesFileName));
      final file = await f.create();
      await file.writeAsString(feature.tableContent);
    }

    final steps = feature
        .getStepFiles()
        .whereType<NewStepFile>()
        .map((e) => createFileRecursively(e.filename, e.dartContent));
    await Future.wait(steps);
  }

  Future<void> createFileRecursively(String filename, String content) async {
    final f = File(filename);
    if (f.existsSync()) {
      return;
    }
    final file = await f.create(recursive: true);
    await file.writeAsString(content);
  }

  @override
  final buildExtensions = const {
    '.feature': ['_test.dart']
  };
}
