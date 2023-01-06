// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myflights_upcoming_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelMyFlightsUpcomingAdapter
    extends TypeAdapter<ModelMyFlightsUpcoming> {
  @override
  final int typeId = 0;

  @override
  ModelMyFlightsUpcoming read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelMyFlightsUpcoming(
      flightCode: fields[0] as String?,
      departureCityDate: fields[1] as String?,
      departureCity: fields[2] as String?,
      departureCityShortCode: fields[3] as String?,
      departureCityTime: fields[4] as String?,
      arrivalCity: fields[5] as String?,
      arrivalCityShortCode: fields[6] as String?,
      arrivalCityTime: fields[7] as String?,
      arrivalCityDate: fields[8] as String?,
      trackFlight: fields[9] as String?,
      details: fields[10] as String?,
      flightStatus: fields[11] as String?,
      isSelected: fields[12] as dynamic,
      flightIata: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelMyFlightsUpcoming obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.arrivalCityDate)
      ..writeByte(9)
      ..write(obj.trackFlight)
      ..writeByte(10)
      ..write(obj.details)
      ..writeByte(11)
      ..write(obj.flightStatus)
      ..writeByte(12)
      ..write(obj.isSelected)
      ..writeByte(13)
      ..write(obj.flightIata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelMyFlightsUpcomingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
