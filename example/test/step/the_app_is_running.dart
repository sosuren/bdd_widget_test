import 'package:flutter_test/flutter_test.dart';
import 'package:dummy_yaml/main.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
}
