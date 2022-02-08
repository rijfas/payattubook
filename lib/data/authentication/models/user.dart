import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    this.profileUrl = '',
    required this.fullName,
    required this.phoneNumber,
    required this.address,
  });
  @HiveField(0)
  final String profileUrl;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String address;

  User copyWith({
    String? profileUrl,
    String? fullName,
    String? phoneNumber,
    String? address,
  }) {
    return User(
      profileUrl: profileUrl ?? this.profileUrl,
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
