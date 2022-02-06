// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payattu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PayattuAdapter extends TypeAdapter<Payattu> {
  @override
  final int typeId = 3;

  @override
  Payattu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payattu(
      id: fields[0] as int,
      createdBy: fields[1] as String,
      host: fields[2] as String,
      hostPhoneNumber: fields[3] as String,
      coverImageUrl: fields[4] == null ? '' : fields[4] as String,
      date: fields[5] as DateTime,
      time: fields[6] as TimeOfDay,
      location: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Payattu obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.host)
      ..writeByte(3)
      ..write(obj.hostPhoneNumber)
      ..writeByte(4)
      ..write(obj.coverImageUrl)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayattuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
