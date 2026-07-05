import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/om_user.dart';

class AuthService extends ChangeNotifier {
  String _expectedOtp = '';
  String _pendingPhoneNumber = '';

  bool _isAuthenticated = false;
  OmUser? _currentUser;

  bool get isAuthenticated => _isAuthenticated;
  OmUser? get currentUser => _currentUser;

  /// Étape 1 : envoi du SMS. Retourne l'OTP simulé (visible dans les logs de dev).
  String requestOtp(String phoneNumber) {
    if (!RegExp(r'^\d{9}$').hasMatch(phoneNumber)) {
      throw Exception(
        'Numéro invalide, format attendu : 9 chiffres après +221',
      );
    }
    _pendingPhoneNumber = phoneNumber;
    _expectedOtp = (1000 + Random().nextInt(9000)).toString();
    debugPrint('[SMS simulé] Code envoyé au +221 $phoneNumber : $_expectedOtp');
    return _expectedOtp;
  }

  /// Étape 2 : vérification du code reçu par SMS.
  bool verifyOtp(String code) => code == _expectedOtp;

  /// Étape 3 : vérification du code secret puis connexion.
  bool verifyPin(String pin) {
    if (!RegExp(r'^\d{4}$').hasMatch(pin)) {
      return false;
    }
    _currentUser = OmUser(
      phoneNumber: _pendingPhoneNumber,
      fullName: 'Birane Baila Wane',
      balance: 50000,
    );
    _isAuthenticated = true;
    notifyListeners();
    return true;
  }

  void debit(double total) {
    if (!_isAuthenticated || _currentUser == null) {
      throw Exception(
        'Vous devez être connecté pour effectuer cette opération',
      );
    }
    if (total > _currentUser!.balance) {
      throw Exception('Solde insuffisant');
    }
    _currentUser = _currentUser!.copyWith(
      balance: _currentUser!.balance - total,
    );
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }
}
