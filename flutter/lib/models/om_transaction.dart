enum OperationType { paiement, transfert }

class OmTransaction {
  final OperationType type;
  final String target;
  final double amount;
  final DateTime date;

  const OmTransaction({
    required this.type,
    required this.target,
    required this.amount,
    required this.date,
  });

  String get label => type == OperationType.paiement ? 'Paiement' : "Transfert d'argent";
}
