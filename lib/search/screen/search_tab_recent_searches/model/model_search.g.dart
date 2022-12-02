// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_search.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelSearchAdapter extends TypeAdapter<ModelSearch> {
  @override
  final int typeId = 2;

  @override
  ModelSearch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelSearch(
      arrivalCity: fields[0] as String?,
      departureCity: fields[1] as String?,
      airlineName: fields[4] as String?,
      flightCode: fields[5] as String?,
      arrivalCityShortName: fields[2] as String?,
      departureCityShortName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelSearch obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.arrivalCity)
      ..writeByte(1)
      ..write(obj.departureCity)
      ..writeByte(2)
      ..write(obj.arrivalCityShortName)
      ..writeByte(3)
      ..write(obj.departureCityShortName)
      ..writeByte(4)
      ..write(obj.airlineName)
      ..writeByte(5)
      ..write(obj.flightCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelSearchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
