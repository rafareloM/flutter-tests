import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  MockContactDao mockContactDao;

  setUp(() async {
    mockContactDao = MockContactDao();
  });

  testWidgets(
    'Should save a contact',
    (tester) async {
      final mockTransactionWebClient = MockTransactionWebClient();
      await tester.pumpWidget(
        BytebankApp(
          contactDao: mockContactDao,
          transactionWebClient: mockTransactionWebClient,
        ),
      );
      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      await clickOnTransferFeatureItem(tester);

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      final fab = find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(fab, findsOneWidget);

      await tester.tap(fab);
      await tester.pumpAndSettle();

      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);

      await fillTextFieldByLabel(tester, label: 'Full name', fillText: 'Rafa');

      await fillTextFieldByLabel(tester,
          label: 'Account number', fillText: '1000');

      await clickOnOutlinedButtonByText(tester, 'Create');
      await tester.pumpAndSettle();

      verify(mockContactDao.save(Contact(0, 'Rafa', 1000)));

      final contactsListBack = find.byType(ContactsList);
      expect(contactsListBack, findsOneWidget);

      verify(mockContactDao.findAll());
    },
  );
}
