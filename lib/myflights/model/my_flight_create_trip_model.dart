// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:hive/hive.dart';
import 'myflights_upcoming_model.dart';

part 'my_flight_create_trip_model.g.dart';

@HiveType(typeId: 1)
class ModelMyFlightsCreateTrip extends HiveObject {
  @HiveField(0)
  String tripName;

  @HiveField(1)
  String noOfFlights;

  @HiveField(2)
  String tripImage;

  @HiveField(3)
  var modelMyFlightsUpcoming;
  // List<ModelMyFlightsUpcoming> modelMyFlightsUpcoming;

  @HiveField(4)
  bool? isSelected;

  ModelMyFlightsCreateTrip({
    required this.tripName,
    required this.noOfFlights,
    required this.tripImage,
    required this.modelMyFlightsUpcoming,
    this.isSelected
  });
}