// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investor_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoggedInfoAdapter extends TypeAdapter<LoggedInfo> {
  @override
  final int typeId = 0;

  @override
  LoggedInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoggedInfo(
      userName: fields[1] as String,
      ethAddress: fields[2] as String,
      key: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LoggedInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.ethAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
