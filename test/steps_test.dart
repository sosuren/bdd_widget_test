import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Empty feature file parses', () {
    const path = 'test';

    final feature =
        FeatureFile(featureDir: '$path.feature', tablesFilename: '${path}_tables.dart', package: path, input: '');
    expect(feature.getStepFiles().length, 0);
  });
}
