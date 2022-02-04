import 'package:hive/hive.dart';

part 'user.g.dart';
// import 'dart:convert';

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

  // User copyWith({
  //   String? profileUrl,
  //   String? fullName,
  //   String? phoneNumber,
  //   String? address,
  // }) {
  //   return User(
  //     profileUrl: profileUrl ?? this.profileUrl,
  //     fullName: fullName ?? this.fullName,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     address: address ?? this.address,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'profileUrl': profileUrl,
  //     'fullName': fullName,
  //     'phoneNumber': phoneNumber,
  //     'address': address,
  //   };
  // }

  // factory User.fromMap(Map<String, dynamic> map) {
  //   return User(
  //     profileUrl: map['profileUrl'] ?? '',
  //     fullName: map['fullName'] ?? '',
  //     phoneNumber: map['phoneNumber'] ?? '',
  //     address: map['address'] ?? '',
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory User.fromJson(String source) => User.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'User(profileUrl: $profileUrl, fullName: $fullName, phoneNumber: $phoneNumber, address: $address)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is User &&
  //       other.profileUrl == profileUrl &&
  //       other.fullName == fullName &&
  //       other.phoneNumber == phoneNumber &&
  //       other.address == address;
  // }

  // @override
  // int get hashCode {
  //   return profileUrl.hashCode ^
  //       fullName.hashCode ^
  //       phoneNumber.hashCode ^
  //       address.hashCode;
  // }
}
