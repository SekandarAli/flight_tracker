// To parse this JSON data, do
//
//     final modelAirport = modelAirportFromJson(jsonString);

import 'dart:convert';

ModelAirport modelAirportFromJson(String str) => ModelAirport.fromJson(json.decode(str));

String modelAirportToJson(ModelAirport data) => json.encode(data.toJson());

class ModelAirport {
  ModelAirport({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  List<Datum>? data;

  factory ModelAirport.fromJson(Map<String, dynamic> json) => ModelAirport(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination == null ? null : pagination!.toJson(),
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.gmt,
    this.airportId,
    this.iataCode,
    this.cityIataCode,
    this.icaoCode,
    this.countryIso2,
    this.geonameId,
    this.latitude,
    this.longitude,
    this.airportName,
    this.countryName,
    this.phoneNumber,
    this.timezone,
  });

  String? id;
  String? gmt;
  String? airportId;
  String? iataCode;
  String? cityIataCode;
  String? icaoCode;
  String? countryIso2;
  String? geonameId;
  String? latitude;
  String? longitude;
  String? airportName;
  String? countryName;
  dynamic phoneNumber;
  String? timezone;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    gmt: json["gmt"] == null ? null : json["gmt"],
    airportId: json["airport_id"] == null ? null : json["airport_id"],
    iataCode: json["iata_code"] == null ? null : json["iata_code"],
    cityIataCode: json["city_iata_code"] == null ? null : json["city_iata_code"],
    icaoCode: json["icao_code"] == null ? null : json["icao_code"],
    countryIso2: json["country_iso2"] == null ? null : json["country_iso2"],
    geonameId: json["geoname_id"] == null ? null : json["geoname_id"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    airportName: json["airport_name"] == null ? null : json["airport_name"],
    countryName: json["country_name"] == null ? null : json["country_name"],
    phoneNumber: json["phone_number"],
    timezone: json["timezone"] == null ? null : json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "gmt": gmt == null ? null : gmt,
    "airport_id": airportId == null ? null : airportId,
    "iata_code": iataCode == null ? null : iataCode,
    "city_iata_code": cityIataCode == null ? null : cityIataCode,
    "icao_code": icaoCode == null ? null : icaoCode,
    "country_iso2": countryIso2 == null ? null : countryIso2,
    "geoname_id": geonameId == null ? null : geonameId,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "airport_name": airportName == null ? null : airportName,
    "country_name": countryName == null ? null : countryName,
    "phone_number": phoneNumber,
    "timezone": timezone == null ? null : timezone,
  };
}

class Pagination {
  Pagination({
    this.offset,
    this.limit,
    this.count,
    this.total,
  });

  int? offset;
  int? limit;
  int? count;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    offset: json["offset"] == null ? null : json["offset"],
    limit: json["limit"] == null ? null : json["limit"],
    count: json["count"] == null ? null : json["count"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "offset": offset == null ? null : offset,
    "limit": limit == null ? null : limit,
    "count": count == null ? null : count,
    "total": total == null ? null : total,
  };
}
