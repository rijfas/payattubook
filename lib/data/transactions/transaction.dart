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
}
