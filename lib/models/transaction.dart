
enum TransactionType { income, expense }

class DailyTransaction {
  final String id;
  final DateTime date;
  final String label;
  final double amount;
  final TransactionType type;
  final String? employeeId;
  final double commissionAmount;

  DailyTransaction({
    required this.id,
    required this.date,
    required this.label,
    required this.amount,
    required this.type,
    this.employeeId,
    this.commissionAmount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'label': label,
      'amount': amount,
      'type': type.index,
      'employeeId': employeeId,
      'commissionAmount': commissionAmount,
    };
  }

  factory DailyTransaction.fromMap(Map<String, dynamic> map) {
    return DailyTransaction(
      id: map['id'],
      date: DateTime.parse(map['date']),
      label: map['label'],
      amount: map['amount'],
      type: TransactionType.values[map['type']],
      employeeId: map['employeeId'],
      commissionAmount: map['commissionAmount'] ?? 0,
    );
  }
}
