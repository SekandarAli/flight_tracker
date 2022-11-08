// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myflights_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelMyFlightsAdapter extends TypeAdapter<ModelMyFlights> {
  @override
  final int typeId = 0;

  @override
  ModelMyFlights read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelMyFlights(
      flightCode: fields[0] as String,
      departureCityDate: fields[1] as String,
      departureCity: fields[2] as String,
      departureCityShortCode: fields[3] as String,
      departureCityTime: fields[4] as String,
      arrivalCity: fields[5] as String,
      arrivalCityShortCode: fields[6] as String,
      arrivalCityTime: fields[7] as String,
      arrivalCityDate: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModelMyFlights obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.flightCode)
      ..writeByte(1)
      ..write(obj.departureCityDate)
      ..writeByte(2)
      ..write(obj.departureCity)
      ..writeByte(3)
      ..write(obj.departureCityShortCode)
      ..writeByte(4)
      ..write(obj.departureCityTime)
      ..writeByte(5)
      ..write(obj.arrivalCity)
      ..writeByte(6)
      ..write(obj.arrivalCityShortCode)
      ..writeByte(7)
      ..write(obj.arrivalCityTime)
      ..writeByte(8)
      ..write(obj.arrivalCityDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelMyFlightsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
