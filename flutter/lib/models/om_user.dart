class OmUser {
  final String phoneNumber;
  final String fullName;
  final double balance;

  const OmUser({
    required this.phoneNumber,
    required this.fullName,
    required this.balance,
  });

  OmUser copyWith({double? balance}) {
    return OmUser(
      phoneNumber: phoneNumber,
      fullName: fullName,
      balance: balance ?? this.balance,
    );
  }
}
