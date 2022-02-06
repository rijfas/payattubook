import 'package:hive/hive.dart';
import '../../discover_payattu/models/payattu.dart';

part 'user_payattu.g.dart';

@HiveType(typeId: 2)
class UserPayattu {
  UserPayattu({
    required this.payattu,
    required this.amount,
  });
  @HiveField(0)
  final Payattu payattu;
  @HiveField(1)
  final double amount;
}
