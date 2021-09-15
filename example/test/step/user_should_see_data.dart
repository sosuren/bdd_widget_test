import 'package:flutter_test/flutter_test.dart';
import 'package:bdd_widget_test/bdd_widget_test.dart';

Future<void> userShouldSeeData(WidgetTester tester, dynamic table) async {
  final data = table as StepTable;
  print('>>> ${data.header.names.join(',')}');
  for (final row in data.rows) {
    print('--- ${row.values.join(',')}');
  }
}
