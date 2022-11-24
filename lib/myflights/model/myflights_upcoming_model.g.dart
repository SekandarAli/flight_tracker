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
      flightCode: fields[0] as String,
      departureCityDate: fields[1] as String,
      departureCity: fields[2] as String,
      departureCityShortCode: fields[3] as String,
      departureCityTime: fields[4] as String,
      arrivalCity: fields[5] as String,
      arrivalCityShortCode: fields[6] as String,
      arrivalCityTime: fields[7] as String,
      arrivalCityDate: fields[8] as String,
      departureLat: fields[9] as String?,
      departureLng: fields[10] as String?,
      arrivalLat: fields[11] as String?,
      arrivalLng: fields[12] as String?,
      departureTerminal: fields[13] as String?,
      arrivalTerminal: fields[14] as String?,
      departureGate: fields[15] as String?,
      arrivalGate: fields[16] as String?,
      distance: fields[17] as String?,
      duration: fields[18] as String?,
      flightTimeLeft: fields[19] as String?,
      baggage: fields[20] as String?,
      departureAirport: fields[21] as String?,
      arrivalAirport: fields[22] as String?,
      flightStatus: fields[23] as String?,
      isSelected: fields[24] == null ? false : fields[24] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelMyFlightsUpcoming obj) {
    writer
      ..writeByte(25)
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
      ..write(obj.departureLat)
      ..writeByte(10)
      ..write(obj.departureLng)
      ..writeByte(11)
      ..write(obj.arrivalLat)
      ..writeByte(12)
      ..write(obj.arrivalLng)
      ..writeByte(13)
      ..write(obj.departureTerminal)
      ..writeByte(14)
      ..write(obj.arrivalTerminal)
      ..writeByte(15)
      ..write(obj.departureGate)
      ..writeByte(16)
      ..write(obj.arrivalGate)
      ..writeByte(17)
      ..write(obj.distance)
      ..writeByte(18)
      ..write(obj.duration)
      ..writeByte(19)
      ..write(obj.flightTimeLeft)
      ..writeByte(20)
      ..write(obj.baggage)
      ..writeByte(21)
      ..write(obj.departureAirport)
      ..writeByte(22)
      ..write(obj.arrivalAirport)
      ..writeByte(23)
      ..write(obj.flightStatus)
      ..writeByte(24)
      ..write(obj.isSelected);
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
