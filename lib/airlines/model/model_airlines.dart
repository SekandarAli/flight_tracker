// To parse this JSON data, do
//
//     final modelAirlines = modelAirlinesFromJson(jsonString);

import 'dart:convert';

ModelAirlines modelAirlinesFromJson(String str) => ModelAirlines.fromJson(json.decode(str));

String modelAirlinesToJson(ModelAirlines data) => json.encode(data.toJson());

class ModelAirlines {
  ModelAirlines({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  List<Datum>? data;

  factory ModelAirlines.fromJson(Map<String, dynamic> json) => ModelAirlines(
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
    this.fleetAverageAge,
    this.airlineId,
    this.callsign,
    this.hubCode,
    this.iataCode,
    this.icaoCode,
    this.countryIso2,
    this.dateFounded,
    this.iataPrefixAccounting,
    this.airlineName,
    this.countryName,
    this.fleetSize,
    this.status,
    this.type,
  });

  String? id;
  String? fleetAverageAge;
  String? airlineId;
  String? callsign;
  String? hubCode;
  String? iataCode;
  String? icaoCode;
  String? countryIso2;
  String? dateFounded;
  String? iataPrefixAccounting;
  String? airlineName;
  String? countryName;
  String? fleetSize;
  String? status;
  String? type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    fleetAverageAge: json["fleet_average_age"] == null ? null : json["fleet_average_age"],
    airlineId: json["airline_id"] == null ? null : json["airline_id"],
    callsign: json["callsign"] == null ? null : json["callsign"],
    hubCode: json["hub_code"] == null ? null : json["hub_code"],
    iataCode: json["iata_code"] == null ? null : json["iata_code"],
    icaoCode: json["icao_code"] == null ? null : json["icao_code"],
    countryIso2: json["country_iso2"] == null ? null : json["country_iso2"],
    dateFounded: json["date_founded"] == null ? null : json["date_founded"],
    iataPrefixAccounting: json["iata_prefix_accounting"] == null ? null : json["iata_prefix_accounting"],
    airlineName: json["airline_name"] == null ? null : json["airline_name"],
    countryName: json["country_name"] == null ? null : json["country_name"],
    fleetSize: json["fleet_size"] == null ? null : json["fleet_size"],
    status: json["status"] == null ? null : json["status"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fleet_average_age": fleetAverageAge == null ? null : fleetAverageAge,
    "airline_id": airlineId == null ? null : airlineId,
    "callsign": callsign == null ? null : callsign,
    "hub_code": hubCode == null ? null : hubCode,
    "iata_code": iataCode == null ? null : iataCode,
    "icao_code": icaoCode == null ? null : icaoCode,
    "country_iso2": countryIso2 == null ? null : countryIso2,
    "date_founded": dateFounded == null ? null : dateFounded,
    "iata_prefix_accounting": iataPrefixAccounting == null ? null : iataPrefixAccounting,
    "airline_name": airlineName == null ? null : airlineName,
    "country_name": countryName == null ? null : countryName,
    "fleet_size": fleetSize == null ? null : fleetSize,
    "status": status == null ? null : status,
    "type": type == null ? null : type,
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
