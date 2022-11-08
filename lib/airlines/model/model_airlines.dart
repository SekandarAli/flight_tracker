// To parse this JSON data, do
//
//     final modelAirlines = modelAirlinesFromJson(jsonString);

import 'dart:convert';

List<ModelAirlines> modelAirlinesFromJson(String str) => List<ModelAirlines>.from(json.decode(str).map((x) => ModelAirlines.fromJson(x)));

String modelAirlinesToJson(List<ModelAirlines> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelAirlines {
  ModelAirlines({
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
  Status? status;
  Type? type;

  factory ModelAirlines.fromJson(Map<String, dynamic> json) => ModelAirlines(
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
    status: json["status"] == null ? null : statusValues.map![json["status"]],
    type: json["type"] == null ? null : typeValues.map![json["type"]],
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
    "status": status == null ? null : statusValues.reverse[status],
    "type": type == null ? null : typeValues.reverse[type],
  };
}

enum Status { ACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

enum Type { SCHEDULED, SCHEDULED_CHARTER, SCHEDULED_CARGO }

final typeValues = EnumValues({
  "scheduled": Type.SCHEDULED,
  "scheduled,cargo": Type.SCHEDULED_CARGO,
  "scheduled,charter": Type.SCHEDULED_CHARTER
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
