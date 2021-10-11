// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bdd_widget_test/bdd_widget_test.dart';

import './authenticate_tables.dart';

import './step/i_should_be_able_to_login_with_valid_credential.dart';
import './step/i_am_in_the_login_page.dart';
import './step/i_enter_these_data_in_the_login_form.dart';
import './step/i_should_see_these_results_in_the_home_page.dart';
import './step/i_should_be_able_to_signup.dart';
import './step/i_am_in_the_signup_page.dart';
import './step/i_enter_these_data_in_the_signup_form.dart';

void main() {
  group('Authentication', () {
    testWidgets('I should be able to login with valid credential', (tester) async {
      await iShouldBeAbleToLoginWithValidCredential();
      await iAmInTheLoginPage(tester);
      await iEnterTheseDataInTheLoginForm(tester, featureTables['459167760']!['188914375']!.copyWithRow(0));
      await iShouldSeeTheseResultsInTheHomePage(tester, featureTables['459167760']!['487558718']!.copyWithRow(0));
    });
    testWidgets('I should be able to login with valid credential', (tester) async {
      await iShouldBeAbleToLoginWithValidCredential();
      await iAmInTheLoginPage(tester);
      await iEnterTheseDataInTheLoginForm(tester, featureTables['459167760']!['188914375']!.copyWithRow(1));
      await iShouldSeeTheseResultsInTheHomePage(tester, featureTables['459167760']!['487558718']!.copyWithRow(1));
    });
    testWidgets('I should be able to signup', (tester) async {
      await iShouldBeAbleToSignup();
      await iAmInTheSignupPage(tester);
      await iEnterTheseDataInTheSignupForm(tester, featureTables['860501932']!['945822693']!.copyWithRow(0));
      await iShouldSeeTheseResultsInTheHomePage(tester, featureTables['860501932']!['487558718']!.copyWithRow(0));
    });
  });
}
