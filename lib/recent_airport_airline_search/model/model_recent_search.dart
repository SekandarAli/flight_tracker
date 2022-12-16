// ignore_for_file: prefer_const_constructors

import 'package:hive/hive.dart';
part 'model_recent_search.g.dart';

@HiveType(typeId: 3)
class ModelRecentSearch extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? cityShortCode;

  @HiveField(2)
  String? countryShortCode;

  ModelRecentSearch({this.name, this.cityShortCode,this.countryShortCode});
}