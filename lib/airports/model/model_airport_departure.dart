// To parse this JSON data, do
//
//     final modelAirportDepArr = modelAirportDepArrFromJson(jsonString);

import 'dart:convert';

ModelAirportDeparture modelAirportDepartureFromJson(String str) => ModelAirportDeparture.fromJson(json.decode(str));

String modelAirportDepartureToJson(ModelAirportDeparture data) => json.encode(data.toJson());

class ModelAirportDeparture {
  ModelAirportDeparture({
    this.request,
    this.response,
    this.terms,
  });

  Request? request;
  List<Response>? response;
  String? terms;

  factory ModelAirportDeparture.fromJson(Map<String, dynamic> json) => ModelAirportDeparture(
    request: json["request"] == null ? null : Request.fromJson(json["request"]),
    response: json["response"] == null ? null : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
    terms: json["terms"] == null ? null : json["terms"],
  );

  Map<String, dynamic> toJson() => {
    "request": request == null ? null : request!.toJson(),
    "response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
    "terms": terms == null ? null : terms,
  };
}

class Request {
  Request({
    this.lang,
    this.currency,
    this.time,
    this.id,
    this.server,
    this.host,
    this.pid,
    this.key,
    this.params,
    this.version,
    this.method,
    this.client,
  });

  String? lang;
  String? currency;
  int? time;
  String? id;
  String? server;
  String? host;
  int? pid;
  Key? key;
  Params? params;
  int? version;
  String? method;
  Client? client;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    lang: json["lang"] == null ? null : json["lang"],
    currency: json["currency"] == null ? null : json["currency"],
    time: json["time"] == null ? null : json["time"],
    id: json["id"] == null ? null : json["id"],
    server: json["server"] == null ? null : json["server"],
    host: json["host"] == null ? null : json["host"],
    pid: json["pid"] == null ? null : json["pid"],
    key: json["key"] == null ? null : Key.fromJson(json["key"]),
    params: json["params"] == null ? null : Params.fromJson(json["params"]),
    version: json["version"] == null ? null : json["version"],
    method: json["method"] == null ? null : json["method"],
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "lang": lang == null ? null : lang,
    "currency": currency == null ? null : currency,
    "time": time == null ? null : time,
    "id": id == null ? null : id,
    "server": server == null ? null : server,
    "host": host == null ? null : host,
    "pid": pid == null ? null : pid,
    "key": key == null ? null : key!.toJson(),
    "params": params == null ? null : params!.toJson(),
    "version": version == null ? null : version,
    "method": method == null ? null : method,
    "client": client == null ? null : client!.toJson(),
  };
}

class Client {
  Client({
    this.ip,
    this.geo,
    this.connection,
    this.device,
    this.agent,
    this.karma,
  });

  String? ip;
  Geo? geo;
  Connection? connection;
  Agent? device;
  Agent? agent;
  Karma? karma;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    ip: json["ip"] == null ? null : json["ip"],
    geo: json["geo"] == null ? null : Geo.fromJson(json["geo"]),
    connection: json["connection"] == null ? null : Connection.fromJson(json["connection"]),
    device: json["device"] == null ? null : Agent.fromJson(json["device"]),
    agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
    karma: json["karma"] == null ? null : Karma.fromJson(json["karma"]),
  );

  Map<String, dynamic> toJson() => {
    "ip": ip == null ? null : ip,
    "geo": geo == null ? null : geo!.toJson(),
    "connection": connection == null ? null : connection!.toJson(),
    "device": device == null ? null : device!.toJson(),
    "agent": agent == null ? null : agent!.toJson(),
    "karma": karma == null ? null : karma!.toJson(),
  };
}

class Agent {
  Agent();

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Connection {
  Connection({
    this.type,
  });

  String? type;

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
  };
}

class Geo {
  Geo({
    this.countryCode,
    this.country,
    this.continent,
    this.city,
    this.lat,
    this.lng,
    this.timezone,
  });

  String? countryCode;
  String? country;
  String? continent;
  String? city;
  double? lat;
  double? lng;
  String? timezone;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    countryCode: json["country_code"] == null ? null : json["country_code"],
    country: json["country"] == null ? null : json["country"],
    continent: json["continent"] == null ? null : json["continent"],
    city: json["city"] == null ? null : json["city"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
    timezone: json["timezone"] == null ? null : json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode == null ? null : countryCode,
    "country": country == null ? null : country,
    "continent": continent == null ? null : continent,
    "city": city == null ? null : city,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "timezone": timezone == null ? null : timezone,
  };
}

class Karma {
  Karma({
    this.isBlocked,
    this.isCrawler,
    this.isBot,
    this.isFriend,
    this.isRegular,
  });

  bool? isBlocked;
  bool? isCrawler;
  bool? isBot;
  bool? isFriend;
  bool? isRegular;

  factory Karma.fromJson(Map<String, dynamic> json) => Karma(
    isBlocked: json["is_blocked"] == null ? null : json["is_blocked"],
    isCrawler: json["is_crawler"] == null ? null : json["is_crawler"],
    isBot: json["is_bot"] == null ? null : json["is_bot"],
    isFriend: json["is_friend"] == null ? null : json["is_friend"],
    isRegular: json["is_regular"] == null ? null : json["is_regular"],
  );

  Map<String, dynamic> toJson() => {
    "is_blocked": isBlocked == null ? null : isBlocked,
    "is_crawler": isCrawler == null ? null : isCrawler,
    "is_bot": isBot == null ? null : isBot,
    "is_friend": isFriend == null ? null : isFriend,
    "is_regular": isRegular == null ? null : isRegular,
  };
}

class Key {
  Key({
    this.id,
    this.apiKey,
    this.type,
    this.expired,
    this.registered,
    this.limitsByHour,
    this.limitsByMinute,
    this.limitsByMonth,
    this.limitsTotal,
  });

  int? id;
  String? apiKey;
  String? type;
  DateTime? expired;
  DateTime? registered;
  int? limitsByHour;
  int? limitsByMinute;
  int? limitsByMonth;
  int? limitsTotal;

  factory Key.fromJson(Map<String, dynamic> json) => Key(
    id: json["id"] == null ? null : json["id"],
    apiKey: json["api_key"] == null ? null : json["api_key"],
    type: json["type"] == null ? null : json["type"],
    expired: json["expired"] == null ? null : DateTime.parse(json["expired"]),
    registered: json["registered"] == null ? null : DateTime.parse(json["registered"]),
    limitsByHour: json["limits_by_hour"] == null ? null : json["limits_by_hour"],
    limitsByMinute: json["limits_by_minute"] == null ? null : json["limits_by_minute"],
    limitsByMonth: json["limits_by_month"] == null ? null : json["limits_by_month"],
    limitsTotal: json["limits_total"] == null ? null : json["limits_total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "api_key": apiKey == null ? null : apiKey,
    "type": type == null ? null : type,
    "expired": expired == null ? null : expired!.toIso8601String(),
    "registered": registered == null ? null : registered!.toIso8601String(),
    "limits_by_hour": limitsByHour == null ? null : limitsByHour,
    "limits_by_minute": limitsByMinute == null ? null : limitsByMinute,
    "limits_by_month": limitsByMonth == null ? null : limitsByMonth,
    "limits_total": limitsTotal == null ? null : limitsTotal,
  };
}

class Params {
  Params({
    this.depIata,
    this.lang,
  });

  DepIata? depIata;
  String? lang;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    depIata: json["dep_iata"] == null ? null : depIataValues.map![json["dep_iata"]],
    lang: json["lang"] == null ? null : json["lang"],
  );

  Map<String, dynamic> toJson() => {
    "dep_iata": depIata == null ? null : depIataValues.reverse[depIata],
    "lang": lang == null ? null : lang,
  };
}

enum DepIata { ORD }

final depIataValues = EnumValues({
  "ORD": DepIata.ORD
});

class Response {
  Response({
    this.airlineIata,
    this.airlineIcao,
    this.flightIata,
    this.flightIcao,
    this.flightNumber,
    this.depIata,
    this.depIcao,
    this.depTerminal,
    this.depGate,
    this.depTime,
    this.depTimeUtc,
    this.depEstimated,
    this.depEstimatedUtc,
    this.depActual,
    this.depActualUtc,
    this.arrIata,
    this.arrIcao,
    this.arrTerminal,
    this.arrGate,
    this.arrBaggage,
    this.arrTime,
    this.arrTimeUtc,
    this.arrEstimated,
    this.arrEstimatedUtc,
    this.csAirlineIata,
    this.csFlightNumber,
    this.csFlightIata,
    this.status,
    this.duration,
    this.delayed,
    this.depDelayed,
    this.arrDelayed,
    this.aircraftIcao,
    this.arrTimeTs,
    this.depTimeTs,
    this.arrEstimatedTs,
    this.depEstimatedTs,
    this.depActualTs,
  });

  String? airlineIata;
  String? airlineIcao;
  String? flightIata;
  String? flightIcao;
  String? flightNumber;
  DepIata? depIata;
  DepIcao? depIcao;
  String? depTerminal;
  String? depGate;
  String? depTime;
  String? depTimeUtc;
  String? depEstimated;
  String? depEstimatedUtc;
  String? depActual;
  String? depActualUtc;
  String? arrIata;
  String? arrIcao;
  String? arrTerminal;
  String? arrGate;
  String? arrBaggage;
  String? arrTime;
  String? arrTimeUtc;
  String? arrEstimated;
  String? arrEstimatedUtc;
  CsAirlineIata? csAirlineIata;
  String? csFlightNumber;
  String? csFlightIata;
  Status? status;
  int? duration;
  int? delayed;
  int? depDelayed;
  int? arrDelayed;
  String? aircraftIcao;
  int? arrTimeTs;
  int? depTimeTs;
  int? arrEstimatedTs;
  int? depEstimatedTs;
  int? depActualTs;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    airlineIata: json["airline_iata"] == null ? null : json["airline_iata"],
    airlineIcao: json["airline_icao"] == null ? null : json["airline_icao"],
    flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
    flightIcao: json["flight_icao"] == null ? null : json["flight_icao"],
    flightNumber: json["flight_number"] == null ? null : json["flight_number"],
    depIata: json["dep_iata"] == null ? null : depIataValues.map![json["dep_iata"]],
    depIcao: json["dep_icao"] == null ? null : depIcaoValues.map![json["dep_icao"]],
    depTerminal: json["dep_terminal"] == null ? null : json["dep_terminal"],
    depGate: json["dep_gate"] == null ? null : json["dep_gate"],
    depTime: json["dep_time"] == null ? null : json["dep_time"],
    depTimeUtc: json["dep_time_utc"] == null ? null : json["dep_time_utc"],
    depEstimated: json["dep_estimated"] == null ? null : json["dep_estimated"],
    depEstimatedUtc: json["dep_estimated_utc"] == null ? null : json["dep_estimated_utc"],
    depActual: json["dep_actual"] == null ? null : json["dep_actual"],
    depActualUtc: json["dep_actual_utc"] == null ? null : json["dep_actual_utc"],
    arrIata: json["arr_iata"] == null ? null : json["arr_iata"],
    arrIcao: json["arr_icao"] == null ? null : json["arr_icao"],
    arrTerminal: json["arr_terminal"] == null ? null : json["arr_terminal"],
    arrGate: json["arr_gate"] == null ? null : json["arr_gate"],
    arrBaggage: json["arr_baggage"] == null ? null : json["arr_baggage"],
    arrTime: json["arr_time"] == null ? null : json["arr_time"],
    arrTimeUtc: json["arr_time_utc"] == null ? null : json["arr_time_utc"],
    arrEstimated: json["arr_estimated"] == null ? null : json["arr_estimated"],
    arrEstimatedUtc: json["arr_estimated_utc"] == null ? null : json["arr_estimated_utc"],
    csAirlineIata: json["cs_airline_iata"] == null ? null : csAirlineIataValues.map![json["cs_airline_iata"]],
    csFlightNumber: json["cs_flight_number"] == null ? null : json["cs_flight_number"],
    csFlightIata: json["cs_flight_iata"] == null ? null : json["cs_flight_iata"],
    status: json["status"] == null ? null : statusValues.map![json["status"]],
    duration: json["duration"] == null ? null : json["duration"],
    delayed: json["delayed"] == null ? null : json["delayed"],
    depDelayed: json["dep_delayed"] == null ? null : json["dep_delayed"],
    arrDelayed: json["arr_delayed"] == null ? null : json["arr_delayed"],
    aircraftIcao: json["aircraft_icao"] == null ? null : json["aircraft_icao"],
    arrTimeTs: json["arr_time_ts"] == null ? null : json["arr_time_ts"],
    depTimeTs: json["dep_time_ts"] == null ? null : json["dep_time_ts"],
    arrEstimatedTs: json["arr_estimated_ts"] == null ? null : json["arr_estimated_ts"],
    depEstimatedTs: json["dep_estimated_ts"] == null ? null : json["dep_estimated_ts"],
    depActualTs: json["dep_actual_ts"] == null ? null : json["dep_actual_ts"],
  );

  Map<String, dynamic> toJson() => {
    "airline_iata": airlineIata == null ? null : airlineIata,
    "airline_icao": airlineIcao == null ? null : airlineIcao,
    "flight_iata": flightIata == null ? null : flightIata,
    "flight_icao": flightIcao == null ? null : flightIcao,
    "flight_number": flightNumber == null ? null : flightNumber,
    "dep_iata": depIata == null ? null : depIataValues.reverse[depIata],
    "dep_icao": depIcao == null ? null : depIcaoValues.reverse[depIcao],
    "dep_terminal": depTerminal == null ? null : depTerminal,
    "dep_gate": depGate == null ? null : depGate,
    "dep_time": depTime == null ? null : depTime,
    "dep_time_utc": depTimeUtc == null ? null : depTimeUtc,
    "dep_estimated": depEstimated == null ? null : depEstimated,
    "dep_estimated_utc": depEstimatedUtc == null ? null : depEstimatedUtc,
    "dep_actual": depActual == null ? null : depActual,
    "dep_actual_utc": depActualUtc == null ? null : depActualUtc,
    "arr_iata": arrIata == null ? null : arrIata,
    "arr_icao": arrIcao == null ? null : arrIcao,
    "arr_terminal": arrTerminal == null ? null : arrTerminal,
    "arr_gate": arrGate == null ? null : arrGate,
    "arr_baggage": arrBaggage == null ? null : arrBaggage,
    "arr_time": arrTime == null ? null : arrTime,
    "arr_time_utc": arrTimeUtc == null ? null : arrTimeUtc,
    "arr_estimated": arrEstimated == null ? null : arrEstimated,
    "arr_estimated_utc": arrEstimatedUtc == null ? null : arrEstimatedUtc,
    "cs_airline_iata": csAirlineIata == null ? null : csAirlineIataValues.reverse[csAirlineIata],
    "cs_flight_number": csFlightNumber == null ? null : csFlightNumber,
    "cs_flight_iata": csFlightIata == null ? null : csFlightIata,
    "status": status == null ? null : statusValues.reverse[status],
    "duration": duration == null ? null : duration,
    "delayed": delayed == null ? null : delayed,
    "dep_delayed": depDelayed == null ? null : depDelayed,
    "arr_delayed": arrDelayed == null ? null : arrDelayed,
    "aircraft_icao": aircraftIcao == null ? null : aircraftIcao,
    "arr_time_ts": arrTimeTs == null ? null : arrTimeTs,
    "dep_time_ts": depTimeTs == null ? null : depTimeTs,
    "arr_estimated_ts": arrEstimatedTs == null ? null : arrEstimatedTs,
    "dep_estimated_ts": depEstimatedTs == null ? null : depEstimatedTs,
    "dep_actual_ts": depActualTs == null ? null : depActualTs,
  };
}

enum CsAirlineIata { AA, DL, UA, B6, OO, MQ, THE_9_E, ZW, G7, YX, QK, AS, CM, OH, THE_9_K, JL, NH, KE }

final csAirlineIataValues = EnumValues({
  "AA": CsAirlineIata.AA,
  "AS": CsAirlineIata.AS,
  "B6": CsAirlineIata.B6,
  "CM": CsAirlineIata.CM,
  "DL": CsAirlineIata.DL,
  "G7": CsAirlineIata.G7,
  "JL": CsAirlineIata.JL,
  "KE": CsAirlineIata.KE,
  "MQ": CsAirlineIata.MQ,
  "NH": CsAirlineIata.NH,
  "OH": CsAirlineIata.OH,
  "OO": CsAirlineIata.OO,
  "QK": CsAirlineIata.QK,
  "9E": CsAirlineIata.THE_9_E,
  "9K": CsAirlineIata.THE_9_K,
  "UA": CsAirlineIata.UA,
  "YX": CsAirlineIata.YX,
  "ZW": CsAirlineIata.ZW
});

enum DepIcao { KORD }

final depIcaoValues = EnumValues({
  "KORD": DepIcao.KORD
});

enum Status { ACTIVE, SCHEDULED, CANCELLED }

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "cancelled": Status.CANCELLED,
  "scheduled": Status.SCHEDULED
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