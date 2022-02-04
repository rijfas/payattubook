import 'package:hive/hive.dart';
import '../../payattu/models/payattu.dart';

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

  // UserPayattu copyWith({
  //   Payattu? payattu,
  //   double? amount,
  // }) {
  //   return UserPayattu(
  //     payattu: payattu ?? this.payattu,
  //     amount: amount ?? this.amount,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'payattu': payattu.toMap(),
  //     'amount': amount,
  //   };
  // }

  // factory UserPayattu.fromMap(Map<String, dynamic> map) {
  //   return UserPayattu(
  //     payattu: Payattu.fromMap(map['payattu']),
  //     amount: map['amount']?.toDouble() ?? 0.0,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory UserPayattu.fromJson(String source) =>
  //     UserPayattu.fromMap(json.decode(source));

  // @override
  // String toString() => 'UserPayattu(payattu: $payattu, amount: $amount)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is UserPayattu &&
  //       other.payattu == payattu &&
  //       other.amount == amount;
  // }

  // @override
  // int get hashCode => payattu.hashCode ^ amount.hashCode;
}
