import 'dart:convert';

import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 5)
class Transaction {
  Transaction({
    required this.id,
    required this.recipient,
    required this.date,
    required this.amount,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String recipient;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final double amount;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipient': recipient,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: "${map['id']}",
      recipient: map['recipient'] ?? '',
      date: DateTime.parse(map['created_at']),
      amount: map['amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
