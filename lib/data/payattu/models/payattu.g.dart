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
      createdBy: fields[0] as String,
      host: fields[1] as String,
      hostPhoneNumber: fields[2] as String,
      coverImageUrl: fields[3] == null ? '' : fields[3] as String,
      date: fields[4] as DateTime,
      time: fields[5] as String,
      location: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Payattu obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.createdBy)
      ..writeByte(1)
      ..write(obj.host)
      ..writeByte(2)
      ..write(obj.hostPhoneNumber)
      ..writeByte(3)
      ..write(obj.coverImageUrl)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
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
