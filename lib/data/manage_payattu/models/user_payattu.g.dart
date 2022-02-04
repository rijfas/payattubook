// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payattu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPayattuAdapter extends TypeAdapter<UserPayattu> {
  @override
  final int typeId = 2;

  @override
  UserPayattu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPayattu(
      payattu: fields[0] as Payattu,
      amount: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserPayattu obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.payattu)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPayattuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
