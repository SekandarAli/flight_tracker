// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelnew.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelNewAdapter extends TypeAdapter<ModelNew> {
  @override
  final int typeId = 4;

  @override
  ModelNew read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelNew(
      modelMyFlightsCreateTrip: fields[0] as ModelMyFlightsCreateTrip,
      modelMyFlightsUpcoming:
          (fields[1] as List?)?.cast<ModelMyFlightsUpcoming>(),
    );
  }

  @override
  void write(BinaryWriter writer, ModelNew obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.modelMyFlightsCreateTrip)
      ..writeByte(1)
      ..write(obj.modelMyFlightsUpcoming);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelNewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
