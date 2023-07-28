import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main() {
  group(
    "When dashboard opens",
    () {
      testWidgets('Should display main image', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: Dashboard(),
        ));
        final mainImage = find.byType(Image);
        expect(mainImage, findsOneWidget);
      });

      testWidgets(
        'Should display transfer featureItem',
        (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Dashboard(),
          ));
          final transferFeatureItem = find.byWidgetPredicate(
            (widget) =>
                featureItemMatcher(widget, 'Transfer', Icons.monetization_on),
          );
          expect(transferFeatureItem, findsOneWidget);
        },
      );
      testWidgets(
        'Should display transaction feed featureItem',
        (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Dashboard(),
          ));
          final transferFeatureItem = find.byWidgetPredicate(
            (widget) => featureItemMatcher(
                widget, 'Transaction Feed', Icons.description),
          );
          expect(transferFeatureItem, findsOneWidget);
        },
      );
    },
  );
}
