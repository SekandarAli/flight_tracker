// ignore_for_file: prefer_const_constructors

import 'package:hive/hive.dart';

part 'myflights_upcoming_model.g.dart';

@HiveType(typeId: 0)
class ModelMyFlightsUpcoming extends HiveObject {
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

  @HiveField(9)
  String? departureLat;

  @HiveField(10)
  String? departureLng;

  @HiveField(11)
  String? arrivalLat;

  @HiveField(12)
  String? arrivalLng;

  // @HiveField(13)
  // String? departureTerminal;
  //
  // @HiveField(14)
  // String? arrivalTerminal;
  //
  // @HiveField(15)
  // String? departureGate;
  //
  // @HiveField(16)
  // String? arrivalGate;
  //
  // @HiveField(17)
  // String? distance;
  //
  // @HiveField(18)
  // String? duration;
  //
  // @HiveField(19)
  // String? flightTimeLeft;
  //
  // @HiveField(20)
  // String? baggage;
  //
  // @HiveField(21)
  // String? departureAirport;
  //
  // @HiveField(22)
  // String? arrivalAirport;

  @HiveField(23)
  String? flightStatus;

  @HiveField(24)
  bool? isSelected;

  @HiveField(25)
  String? flightIata;

  ModelMyFlightsUpcoming({
      required this.flightCode,
      required this.departureCityDate,
      required this.departureCity,
      required this.departureCityShortCode,
      required this.departureCityTime,
      required this.arrivalCity,
      required this.arrivalCityShortCode,
      required this.arrivalCityTime,
      required this.arrivalCityDate,
      this.departureLat,
      this.departureLng,
      this.arrivalLat,
      this.arrivalLng,
      // this.departureTerminal,
      // this.arrivalTerminal,
      // this.departureGate,
      // this.arrivalGate,
      // this.distance,
      // this.duration,
      // this.flightTimeLeft,
      // this.baggage,
      // this.departureAirport,
      // this.arrivalAirport,
      this.flightStatus,
      this.isSelected,
      this.flightIata,
  });
}