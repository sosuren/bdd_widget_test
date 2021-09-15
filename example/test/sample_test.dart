// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_do_not_see_text.dart';
import 'package:bdd_widget_test/step/i_see_text.dart';
import './step/i_am_in_home_page.dart';
import 'package:bdd_widget_test/step/i_tap_icon.dart';
import './step/i_should_see_text.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theAppIsRunning(tester);
  }
  Future<void> bddTearDown(WidgetTester tester) async {
    await iDoNotSeeText(tester, '42');
  }
  group('Counter Feature', () {
    testWidgets('Initial counter value is 0', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, '0');
      await bddTearDown(tester);
    });
    testWidgets('Add button increments the counter', (tester) async {
      await bddSetUp(tester);
      await iAmInHomePage(tester);
      await iTapIcon(tester, Icons.add);
      await iTapIcon(tester, Icons.add);
      await iShouldSeeText(tester, '2');
      await bddTearDown(tester);
    });
  });
}
