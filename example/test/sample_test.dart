// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bdd_widget_test/bdd_widget_test.dart';

import './sample_tables.dart';

import './step/the_user_is_in_the_home_page.dart';
import './step/user_should_be_able_to_navigate_to_login_page.dart';
import './step/user_taps_login_button.dart';
import './step/user_should_see_login_form.dart';
import './step/add_button_increments_the_counter.dart';
import './step/user_enters_these_data_in_the_login_form.dart';
import './step/user_should_see_these_results_in_the_home_page.dart';
import './step/divide_button_increments_the_counter.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theUserIsInTheHomePage(tester);
  }
  group('Counter Feature', () {
    testWidgets('User should be able to navigate to login page', (tester) async {
      await bddSetUp(tester);
      await userShouldBeAbleToNavigateToLoginPage();
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
    });
    testWidgets('Add button increments the counter', (tester) async {
      await bddSetUp(tester);
      await addButtonIncrementsTheCounter();
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersTheseDataInTheLoginForm(tester, featureTables['399448914']!['993915514']!.copyWithRow(0));
      await userShouldSeeTheseResultsInTheHomePage(tester, featureTables['399448914']!['628491749']!.copyWithRow(0));
    });
    testWidgets('Divide button increments the counter', (tester) async {
      await bddSetUp(tester);
      await divideButtonIncrementsTheCounter();
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersTheseDataInTheLoginForm(tester, featureTables['869846095']!['993915514']!.copyWithRow(0));
      await userShouldSeeTheseResultsInTheHomePage(tester, featureTables['869846095']!['628491749']!.copyWithRow(0));
    });
    testWidgets('Divide button increments the counter', (tester) async {
      await bddSetUp(tester);
      await divideButtonIncrementsTheCounter();
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersTheseDataInTheLoginForm(tester, featureTables['869846095']!['993915514']!.copyWithRow(1));
      await userShouldSeeTheseResultsInTheHomePage(tester, featureTables['869846095']!['628491749']!.copyWithRow(1));
    });
  });
}
