import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(
      BytebankApp(
        contactDao: mockContactDao,
        transactionWebClient: mockTransactionWebClient,
      ),
    );
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    Contact contact = Contact(0, 'Rafa', 1000);

    when(mockContactDao.findAll())
        .thenAnswer(((realInvocation) async => [contact]));
    await clickOnTransferFeatureItem(tester);

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == "Rafa" &&
            widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);

    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Rafa');
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text('1000');
    expect(contactAccountNumber, findsOneWidget);

    await fillTextFieldByLabel(tester, label: 'Value', fillText: '200');
    await clickOnOutlinedButtonByText(tester, 'Transfer');

    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    await fillTextFieldByKey(tester,
        key: transactionAuthDialogTextFieldPassword, fillText: '1000');

    final cancelButton = find.widgetWithText(OutlinedButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    when(mockTransactionWebClient.save(Transaction(null, 200, contact), '1000'))
        .thenAnswer((_) async => Transaction(null, 200, contact));

    await clickOnOutlinedButtonByText(tester, 'Confirm');

    await tester.pumpAndSettle();

    final succesDialog = find.byType(SuccessDialog);
    expect(succesDialog, findsOneWidget);

    await clickOnOutlinedButtonByText(tester, 'Ok');

    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);
  });
}
