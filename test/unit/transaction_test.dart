import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should return same value',
    () {
      Transaction transaction = Transaction(null, 200, null);
      expect(transaction.value, 200);
    },
  );
  test(
    'should throw assertion error',
    () {
      expect(() => Transaction(null, 0, null), throwsAssertionError);
    },
  );
}
