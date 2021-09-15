// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bdd_widget_test/bdd_widget_test.dart';

import './sample_tables.dart';

import './step/the_user_is_in_the_home_page.dart';
import './step/user_taps_login_button.dart';
import './step/user_should_see_login_form.dart';
import './step/user_enters_data.dart';
import './step/user_should_see_data.dart';

void main() {
  group('Counter Feature', () {
    testWidgets('Add button increments the counter', (tester) async {
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersData(tester, featureTables['399448914']!['971188439']!.copyWithRow(0));
      await userShouldSeeData(tester, featureTables['399448914']!['279195516']!.copyWithRow(0));
    });
    testWidgets('Divide button increments the counter', (tester) async {
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersData(tester, featureTables['869846095']!['971188439']!.copyWithRow(0));
      await userShouldSeeData(tester, featureTables['869846095']!['279195516']!.copyWithRow(0));
    });
    testWidgets('Divide button increments the counter', (tester) async {
      await theUserIsInTheHomePage(tester);
      await userTapsLoginButton(tester);
      await userShouldSeeLoginForm(tester);
      await userEntersData(tester, featureTables['869846095']!['971188439']!.copyWithRow(1));
      await userShouldSeeData(tester, featureTables['869846095']!['279195516']!.copyWithRow(1));
    });
  });
}
