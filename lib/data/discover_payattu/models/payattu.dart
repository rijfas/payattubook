import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'payattu.g.dart';

@HiveType(typeId: 3)
class Payattu {
  Payattu({
    required this.id,
    required this.createdBy,
    required this.host,
    required this.hostPhoneNumber,
    this.coverImageUrl = '',
    required this.date,
    required this.time,
    required this.location,
  });
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String createdBy;
  @HiveField(2)
  final String host;
  @HiveField(3)
  final String hostPhoneNumber;
  @HiveField(4, defaultValue: '')
  final String coverImageUrl;
  @HiveField(5)
  final DateTime date;
  @HiveField(6)
  final TimeOfDay time;
  @HiveField(7)
  final String location;
}
