// ignore_for_file: prefer_const_constructors

import 'package:hive/hive.dart';

part 'myflights_model.g.dart';

@HiveType(typeId: 0)
class ModelMyFlights extends HiveObject {
  @HiveField(0)
  String flightCode;

  @HiveField(1)
  String departureCityDate;

  @HiveField(2)
  String departureCity;

  @HiveField(3)
  String departureCityShortCode;

  @HiveField(4)
  String departureCityTime;

  @HiveField(5)
  String arrivalCity;

  @HiveField(6)
  String arrivalCityShortCode;

  @HiveField(7)
  String arrivalCityTime;

  @HiveField(8)
  String arrivalCityDate;

  ModelMyFlights({
      required this.flightCode,
      required this.departureCityDate,
      required this.departureCity,
      required this.departureCityShortCode,
      required this.departureCityTime,
      required this.arrivalCity,
      required this.arrivalCityShortCode,
      required this.arrivalCityTime,
      required this.arrivalCityDate
  });
}