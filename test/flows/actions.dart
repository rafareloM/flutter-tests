import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> clickOnTransferFeatureItem(WidgetTester tester) async {
  final transferFeatureItem = find.byWidgetPredicate((widget) =>
      featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(transferFeatureItem, findsOneWidget);
  await tester.tap(transferFeatureItem);
  await tester.pumpAndSettle();
}

Future<void> fillTextFieldByLabel(WidgetTester tester,
    {String label, String fillText}) async {
  final textField =
      find.byWidgetPredicate((widget) => textFieldMatcher(widget, label));
  expect(textField, findsOneWidget);
  await tester.enterText(textField, fillText);
}

Future<void> fillTextFieldByKey(WidgetTester tester,
    {Key key, String fillText}) async {
  final textField = find.byKey(key);
  expect(textField, findsOneWidget);
  await tester.enterText(textField, fillText);
}

Future<void> clickOnOutlinedButtonByText(
    WidgetTester tester, String label) async {
  final button = find.widgetWithText(OutlinedButton, label);
  expect(button, findsOneWidget);
  await tester.tap(button);
}
