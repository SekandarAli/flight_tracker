// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_recent_search.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelRecentSearchAdapter extends TypeAdapter<ModelRecentSearch> {
  @override
  final int typeId = 3;

  @override
  ModelRecentSearch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelRecentSearch(
      name: fields[0] as String?,
      cityShortCode: fields[1] as String?,
      countryShortCode: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelRecentSearch obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cityShortCode)
      ..writeByte(2)
      ..write(obj.countryShortCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelRecentSearchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
