// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_flight_create_trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelMyFlightsCreateTripAdapter
    extends TypeAdapter<ModelMyFlightsCreateTrip> {
  @override
  final int typeId = 1;

  @override
  ModelMyFlightsCreateTrip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelMyFlightsCreateTrip(
      tripName: fields[0] as String,
      noOfFlights: fields[1] as String,
      tripImage: fields[2] as String,
      modelMyFlightsUpcoming: fields[3] as dynamic,
      idNumber: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ModelMyFlightsCreateTrip obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tripName)
      ..writeByte(1)
      ..write(obj.noOfFlights)
      ..writeByte(2)
      ..write(obj.tripImage)
      ..writeByte(3)
      ..write(obj.modelMyFlightsUpcoming)
      ..writeByte(4)
      ..write(obj.idNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelMyFlightsCreateTripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
