import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

import '../database/dao/contact_dao.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;
  const AppDependencies(
      {@required this.contactDao,
      @required this.transactionWebClient,
      @required this.child})
      : super(child: child);

  final Widget child;

  static AppDependencies of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>();
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao ||
        transactionWebClient != oldWidget.transactionWebClient;
  }
}
