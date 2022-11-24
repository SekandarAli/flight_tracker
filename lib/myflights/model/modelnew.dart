
import 'package:hive/hive.dart';

import 'my_flight_create_trip_model.dart';
import 'myflights_upcoming_model.dart';
part 'modelnew.g.dart';

// to run this "flutter packages pub run build_runner build"

@HiveType(typeId: 4)
class ModelNew extends HiveObject {

  @HiveField(0)
  ModelMyFlightsCreateTrip modelMyFlightsCreateTrip;

  @HiveField(1)
  List<ModelMyFlightsUpcoming>? modelMyFlightsUpcoming;


  ModelNew({
    required this.modelMyFlightsCreateTrip,
    required this.modelMyFlightsUpcoming,
  });
}