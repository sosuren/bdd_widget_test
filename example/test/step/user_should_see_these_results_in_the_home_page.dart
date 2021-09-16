import 'package:flutter_test/flutter_test.dart';
import 'package:bdd_widget_test/bdd_widget_test.dart';

Future<void> userShouldSeeTheseResultsInTheHomePage(WidgetTester tester, StepTable table) async {
  print('>>> ${table.header.names.join(',')}');
  for (final row in table.rows) {
    print('--- ${row.values.join(',')}');
  }
}
