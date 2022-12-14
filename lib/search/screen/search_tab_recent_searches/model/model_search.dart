// ignore_for_file: prefer_const_constructors

import 'package:hive/hive.dart';
part 'model_search.g.dart';

@HiveType(typeId: 2)
class ModelSearch extends HiveObject {
  @HiveField(0)
  String? arrivalCity;

  @HiveField(1)
  String? departureCity;

  @HiveField(2)
  String? airlineName;

  @HiveField(3)
  String? flightCode;

  ModelSearch({ this.arrivalCity, this.departureCity,this.airlineName,this.flightCode});
}