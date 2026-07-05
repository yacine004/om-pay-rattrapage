import 'package:flutter/foundation.dart';
import '../models/om_transaction.dart';
import 'auth_service.dart';

const double _transferFeeRate = 0.01;

class TransactionService extends ChangeNotifier {
  final AuthService authService;

  TransactionService(this.authService);

  final List<OmTransaction> _history = [
    OmTransaction(
      type: OperationType.transfert,
      target: '772775076',
      amount: 10,
      date: DateTime(2026, 11, 24, 13, 47),
    ),
    OmTransaction(
      type: OperationType.transfert,
      target: '781534929',
      amount: 26260,
      date: DateTime(2026, 11, 23, 13, 51),
    ),
  ];

  List<OmTransaction> get history => List.unmodifiable(_history);

  void payer(String merchantCode, double amount) {
    authService.debit(amount);
    _history.insert(
      0,
      OmTransaction(
        type: OperationType.paiement,
        target: merchantCode,
        amount: amount,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void transferer(String targetNumber, double amount) {
    final fee = amount * _transferFeeRate;
    authService.debit(amount + fee);
    _history.insert(
      0,
      OmTransaction(
        type: OperationType.transfert,
        target: targetNumber,
        amount: amount,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
