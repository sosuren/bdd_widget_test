// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bdd_widget_test/bdd_widget_test.dart';

import './sample_tables.dart';

import './step/the_user_is_in_the_home_page.dart';
import './step/user_taps_login_button.dart';
import './step/user_should_see_login_form.dart';
import './step/user_enters_data_in_the_login_form.dart';
import './step/user_should_see_data_in_the_result_page.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theUserIsInTheHomePage(tester);
  }
  group('Counter Feature', () {
    testWidgets('User should see login form', (tester) async {
      await bddSetUp(tester);
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
    });
    testWidgets('Add button increments the counter', (tester) async {
      await bddSetUp(tester);
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersDataInTheLoginForm(tester, featureTables['399448914']!['455910068']!.copyWithRow(0));
      await userShouldSeeDataInTheResultPage(tester, featureTables['399448914']!['547161467']!.copyWithRow(0));
    });
    testWidgets('Divide button increments the counter', (tester) async {
      await bddSetUp(tester);
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersDataInTheLoginForm(tester, featureTables['869846095']!['455910068']!.copyWithRow(0));
      await userShouldSeeDataInTheResultPage(tester, featureTables['869846095']!['547161467']!.copyWithRow(0));
    });
    testWidgets('Divide button increments the counter', (tester) async {
      await bddSetUp(tester);
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersDataInTheLoginForm(tester, featureTables['869846095']!['455910068']!.copyWithRow(1));
      await userShouldSeeDataInTheResultPage(tester, featureTables['869846095']!['547161467']!.copyWithRow(1));
    });
  });
}
