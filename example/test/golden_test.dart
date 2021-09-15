// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bdd_widget_test/bdd_widget_test.dart';

import './golden_tables.dart';

import './step/the_app_is_running.dart';
import './step/the_user_has_permission.dart';
import './step/i_do_not_see_text.dart';
import './step/the_user_is_registered.dart';
import './step/the_user_is_logged.dart';
import './step/the_user_menu_page_is_opened.dart';
import './step/the_user_tapped_the_home_button.dart';
import './step/the_save_button_is_inactive.dart';
import './step/the_user_enters_data_in_the_create_home_form.dart';
import './step/the_save_button_becomes_active.dart';
import './step/the_user_tapped_the_save_button.dart';
import './step/the_user_is_redirected_to_the_my_home_page.dart';
import './step/the_home_is_created.dart';
import './step/the_user_enters_data_in_the_update_home_form.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theAppIsRunning(tester);
    await theUserHasPermission(tester);
  }
  Future<void> bddTearDown(WidgetTester tester) async {
    await iDoNotSeeText(tester, '42');
  }
  group('Golden Test', () {
    testWidgets('Users is able to create a New Home', (tester) async {
      await bddSetUp(tester);
      await theUserIsRegistered(tester);
      await theUserIsLogged(tester);
      await theUserMenuPageIsOpened(tester);
      await theUserTappedTheHomeButton(tester);
      await theSaveButtonIsInactive(tester);
      await theUserEntersDataInTheCreateHomeForm(tester, featureTables['455684330']['834000508']);
      await theSaveButtonBecomesActive(tester);
      await theUserTappedTheSaveButton(tester);
      await theUserIsRedirectedToTheMyHomePage(tester);
      await theHomeIsCreated(tester);
      await theUserEntersDataInTheUpdateHomeForm(tester, featureTables['455684330']['229420331']);
      await bddTearDown(tester);
    });
    testWidgets('Users is able to update a New Home', (tester) async {
      await bddSetUp(tester);
      await theUserIsRegistered(tester);
      await theUserIsLogged(tester);
      await theUserMenuPageIsOpened(tester);
      await theUserTappedTheHomeButton(tester);
      await theSaveButtonIsInactive(tester);
      await theUserEntersDataInTheCreateHomeForm(tester, featureTables['698049928']['834000508']);
      await theSaveButtonBecomesActive(tester);
      await theUserTappedTheSaveButton(tester);
      await theUserIsRedirectedToTheMyHomePage(tester);
      await theHomeIsCreated(tester);
      await theUserEntersDataInTheUpdateHomeForm(tester, featureTables['698049928']['229420331']);
      await bddTearDown(tester);
    });
  });
}
