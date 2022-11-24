// To parse this JSON data, do
//
//     final ModelAirlineDetails = ModelAirlineDetailsFromJson(jsonString);

import 'dart:convert';

ModelAirlineDetails ModelAirlineDetailsFromJson(String str) => ModelAirlineDetails.fromJson(json.decode(str));

String ModelAirlineDetailsToJson(ModelAirlineDetails data) => json.encode(data.toJson());

class ModelAirlineDetails {
  ModelAirlineDetails({
    this.request,
    this.response,
    this.terms,
  });

  Request? request;
  List<Response>? response;
  String? terms;

  factory ModelAirlineDetails.fromJson(Map<String, dynamic> json) => ModelAirlineDetails(
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
    this.airlineIcao,
    this.lang,
  });

  AirlineIcao? airlineIcao;
  String? lang;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    airlineIcao: json["airline_icao"] == null ? null : airlineIcaoValues.map![json["airline_icao"]],
    lang: json["lang"] == null ? null : json["lang"],
  );

  Map<String, dynamic> toJson() => {
    "airline_icao": airlineIcao == null ? null : airlineIcaoValues.reverse[airlineIcao],
    "lang": lang == null ? null : lang,
  };
}

enum AirlineIcao { UAE }

final airlineIcaoValues = EnumValues({
  "UAE": AirlineIcao.UAE
});

class Response {
  Response({
    this.airlineIata,
    this.airlineIcao,
    this.flightNumber,
    this.flightIata,
    this.flightIcao,
    this.csAirlineIata,
    this.csFlightIata,
    this.csFlightNumber,
    this.depIata,
    this.depIcao,
    this.depTerminals,
    this.depTime,
    this.depTimeUtc,
    this.arrIata,
    this.arrIcao,
    this.arrTerminals,
    this.arrTime,
    this.arrTimeUtc,
    this.duration,
    this.days,
    this.aircraftIcao,
    this.counter,
    this.updated,
  });

  AirlineIata? airlineIata;
  AirlineIcao? airlineIcao;
  String? flightNumber;
  String? flightIata;
  String? flightIcao;
  CsAirlineIata? csAirlineIata;
  String? csFlightIata;
  String? csFlightNumber;
  String? depIata;
  String? depIcao;
  List<String>? depTerminals;
  String? depTime;
  String? depTimeUtc;
  String? arrIata;
  String? arrIcao;
  List<String>? arrTerminals;
  String? arrTime;
  String? arrTimeUtc;
  int? duration;
  List<Day>? days;
  AircraftIcao? aircraftIcao;
  int? counter;
  DateTime? updated;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    airlineIata: json["airline_iata"] == null ? null : airlineIataValues.map![json["airline_iata"]],
    airlineIcao: json["airline_icao"] == null ? null : airlineIcaoValues.map![json["airline_icao"]],
    flightNumber: json["flight_number"] == null ? null : json["flight_number"],
    flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
    flightIcao: json["flight_icao"] == null ? null : json["flight_icao"],
    csAirlineIata: json["cs_airline_iata"] == null ? null : csAirlineIataValues.map![json["cs_airline_iata"]],
    csFlightIata: json["cs_flight_iata"] == null ? null : json["cs_flight_iata"],
    csFlightNumber: json["cs_flight_number"] == null ? null : json["cs_flight_number"],
    depIata: json["dep_iata"] == null ? null : json["dep_iata"],
    depIcao: json["dep_icao"] == null ? null : json["dep_icao"],
    depTerminals: json["dep_terminals"] == null ? null : List<String>.from(json["dep_terminals"].map((x) => x)),
    depTime: json["dep_time"] == null ? null : json["dep_time"],
    depTimeUtc: json["dep_time_utc"] == null ? null : json["dep_time_utc"],
    arrIata: json["arr_iata"] == null ? null : json["arr_iata"],
    arrIcao: json["arr_icao"] == null ? null : json["arr_icao"],
    arrTerminals: json["arr_terminals"] == null ? null : List<String>.from(json["arr_terminals"].map((x) => x)),
    arrTime: json["arr_time"] == null ? null : json["arr_time"],
    arrTimeUtc: json["arr_time_utc"] == null ? null : json["arr_time_utc"],
    duration: json["duration"] == null ? null : json["duration"],
    days: json["days"] == null ? null : List<Day>.from(json["days"].map((x) => dayValues.map![x])),
    aircraftIcao: json["aircraft_icao"] == null ? null : aircraftIcaoValues.map![json["aircraft_icao"]],
    counter: json["counter"] == null ? null : json["counter"],
    updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "airline_iata": airlineIata == null ? null : airlineIataValues.reverse[airlineIata],
    "airline_icao": airlineIcao == null ? null : airlineIcaoValues.reverse[airlineIcao],
    "flight_number": flightNumber == null ? null : flightNumber,
    "flight_iata": flightIata == null ? null : flightIata,
    "flight_icao": flightIcao == null ? null : flightIcao,
    "cs_airline_iata": csAirlineIata == null ? null : csAirlineIataValues.reverse[csAirlineIata],
    "cs_flight_iata": csFlightIata == null ? null : csFlightIata,
    "cs_flight_number": csFlightNumber == null ? null : csFlightNumber,
    "dep_iata": depIata == null ? null : depIata,
    "dep_icao": depIcao == null ? null : depIcao,
    "dep_terminals": depTerminals == null ? null : List<dynamic>.from(depTerminals!.map((x) => x)),
    "dep_time": depTime == null ? null : depTime,
    "dep_time_utc": depTimeUtc == null ? null : depTimeUtc,
    "arr_iata": arrIata == null ? null : arrIata,
    "arr_icao": arrIcao == null ? null : arrIcao,
    "arr_terminals": arrTerminals == null ? null : List<dynamic>.from(arrTerminals!.map((x) => x)),
    "arr_time": arrTime == null ? null : arrTime,
    "arr_time_utc": arrTimeUtc == null ? null : arrTimeUtc,
    "duration": duration == null ? null : duration,
    "days": days == null ? null : List<dynamic>.from(days!.map((x) => dayValues.reverse[x])),
    "aircraft_icao": aircraftIcao == null ? null : aircraftIcaoValues.reverse[aircraftIcao],
    "counter": counter == null ? null : counter,
    "updated": updated == null ? null : updated!.toIso8601String(),
  };
}

enum AircraftIcao { A388, B77_L, B77_W, A319 }

final aircraftIcaoValues = EnumValues({
  "A319": AircraftIcao.A319,
  "A388": AircraftIcao.A388,
  "B77L": AircraftIcao.B77_L,
  "B77W": AircraftIcao.B77_W
});

enum AirlineIata { EK }

final airlineIataValues = EnumValues({
  "EK": AirlineIata.EK
});

enum CsAirlineIata { FZ, MH, BT, AT, G3, THE_4_Z, PG, WS, WR, CM, TP, NI, A3, QF, QQ, B6, AD, GA, CZ, JQ, THE_3_K, S7 }

final csAirlineIataValues = EnumValues({
  "A3": CsAirlineIata.A3,
  "AD": CsAirlineIata.AD,
  "AT": CsAirlineIata.AT,
  "B6": CsAirlineIata.B6,
  "BT": CsAirlineIata.BT,
  "CM": CsAirlineIata.CM,
  "CZ": CsAirlineIata.CZ,
  "FZ": CsAirlineIata.FZ,
  "G3": CsAirlineIata.G3,
  "GA": CsAirlineIata.GA,
  "JQ": CsAirlineIata.JQ,
  "MH": CsAirlineIata.MH,
  "NI": CsAirlineIata.NI,
  "PG": CsAirlineIata.PG,
  "QF": CsAirlineIata.QF,
  "QQ": CsAirlineIata.QQ,
  "S7": CsAirlineIata.S7,
  "3K": CsAirlineIata.THE_3_K,
  "4Z": CsAirlineIata.THE_4_Z,
  "TP": CsAirlineIata.TP,
  "WR": CsAirlineIata.WR,
  "WS": CsAirlineIata.WS
});

enum Day { SUN, MON, TUE, WED, THU, FRI, SAT }

final dayValues = EnumValues({
  "fri": Day.FRI,
  "mon": Day.MON,
  "sat": Day.SAT,
  "sun": Day.SUN,
  "thu": Day.THU,
  "tue": Day.TUE,
  "wed": Day.WED
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
