// ignore_for_file: prefer_const_constructors,  prefer_typing_uninitialized_variables

import 'package:hive/hive.dart';

part 'myflights_upcoming_model.g.dart';

@HiveType(typeId: 0)
class ModelMyFlightsUpcoming extends HiveObject {
  @HiveField(0)
  String? flightCode;

  @HiveField(1)
  String? departureCityDate;

  @HiveField(2)
  String? departureCity;

  @HiveField(3)
  String? departureCityShortCode;

  @HiveField(4)
  String? departureCityTime;

  @HiveField(5)
  String? arrivalCity;

  @HiveField(6)
  String? arrivalCityShortCode;

  @HiveField(7)
  String? arrivalCityTime;

  @HiveField(8)
  String? arrivalCityDate;

  @HiveField(9)
  String? trackFlight;

  @HiveField(10)
  String? details;

  @HiveField(11)
  String? flightStatus;

  @HiveField(12)
  var isSelected;

  @HiveField(13)
  String? flightIata;

  ModelMyFlightsUpcoming({
      this.flightCode,
      this.departureCityDate,
      this.departureCity,
      this.departureCityShortCode,
      this.departureCityTime,
      this.arrivalCity,
      this.arrivalCityShortCode,
      this.arrivalCityTime,
      this.arrivalCityDate,
      this.trackFlight,
      this.details,
      this.flightStatus,
      this.isSelected,
      this.flightIata,
  });
}