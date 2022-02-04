import 'package:hive/hive.dart';

part 'payattu.g.dart';

@HiveType(typeId: 3)
class Payattu {
  Payattu({
    required this.createdBy,
    required this.host,
    required this.hostPhoneNumber,
    this.coverImageUrl = '',
    required this.date,
    required this.time,
    required this.location,
  });
  @HiveField(0)
  final String createdBy;
  @HiveField(1)
  final String host;
  @HiveField(2)
  final String hostPhoneNumber;
  @HiveField(3, defaultValue: '')
  final String coverImageUrl;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final String time;
  @HiveField(6)
  final String location;

  // Payattu copyWith({
  //   String? createdBy,
  //   String? host,
  //   String? hostPhoneNumber,
  //   String? coverImageUrl,
  //   DateTime? date,
  //   String? time,
  //   String? location,
  // }) {
  //   return Payattu(
  //     createdBy: createdBy ?? this.createdBy,
  //     host: host ?? this.host,
  //     hostPhoneNumber: hostPhoneNumber ?? this.hostPhoneNumber,
  //     coverImageUrl: coverImageUrl ?? this.coverImageUrl,
  //     date: date ?? this.date,
  //     time: time ?? this.time,
  //     location: location ?? this.location,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'createdBy': createdBy,
  //     'host': host,
  //     'hostPhoneNumber': hostPhoneNumber,
  //     'coverImageUrl': coverImageUrl,
  //     'date': date.millisecondsSinceEpoch,
  //     'time': time,
  //     'location': location,
  //   };
  // }

  // factory Payattu.fromMap(Map<String, dynamic> map) {
  //   return Payattu(
  //     createdBy: map['createdBy'] ?? '',
  //     host: map['host'] ?? '',
  //     hostPhoneNumber: map['hostPhoneNumber'] ?? '',
  //     coverImageUrl: map['coverImageUrl'] ?? '',
  //     date: DateTime.fromMillisecondsSinceEpoch(map['date']),
  //     time: map['time'] ?? '',
  //     location: map['location'] ?? '',
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Payattu.fromJson(String source) =>
  //     Payattu.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'Payattu(createdBy: $createdBy, host: $host, hostPhoneNumber: $hostPhoneNumber, coverImageUrl: $coverImageUrl, date: $date, time: $time, location: $location)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Payattu &&
  //       other.createdBy == createdBy &&
  //       other.host == host &&
  //       other.hostPhoneNumber == hostPhoneNumber &&
  //       other.coverImageUrl == coverImageUrl &&
  //       other.date == date &&
  //       other.time == time &&
  //       other.location == location;
  // }

  // @override
  // int get hashCode {
  //   return createdBy.hashCode ^
  //       host.hashCode ^
  //       hostPhoneNumber.hashCode ^
  //       coverImageUrl.hashCode ^
  //       date.hashCode ^
  //       time.hashCode ^
  //       location.hashCode;
  // }
}
