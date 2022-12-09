// To parse this JSON data, do
//
//     final modelSearchFlight = modelSearchFlightFromJson(jsonString);

import 'dart:convert';

ModelSearchFlight modelSearchFlightFromJson(String str) => ModelSearchFlight.fromJson(json.decode(str));

String modelSearchFlightToJson(ModelSearchFlight data) => json.encode(data.toJson());

class ModelSearchFlight {
  ModelSearchFlight({
    this.request,
    this.response,
    this.terms,
  });

  Request? request;
  List<Response>? response;
  String? terms;

  factory ModelSearchFlight.fromJson(Map<String, dynamic> json) => ModelSearchFlight(
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
    this.ispCode,
    this.ispName,
  });

  String? type;
  int? ispCode;
  String? ispName;

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
    type: json["type"] == null ? null : json["type"],
    ispCode: json["isp_code"] == null ? null : json["isp_code"],
    ispName: json["isp_name"] == null ? null : json["isp_name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "isp_code": ispCode == null ? null : ispCode,
    "isp_name": ispName == null ? null : ispName,
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
    this.arrIata,
    this.airlineIata,
    this.lang,
  });

  String? depIata;
  String? arrIata;
  String? airlineIata;
  String? lang;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    depIata: json["dep_iata"] == null ? null : json["dep_iata"],
    arrIata: json["arr_iata"] == null ? null : json["arr_iata"],
    airlineIata: json["airline_iata"] == null ? null : json["airline_iata"],
    lang: json["lang"] == null ? null : json["lang"],
  );

  Map<String, dynamic> toJson() => {
    "dep_iata": depIata == null ? null : depIata,
    "arr_iata": arrIata == null ? null : arrIata,
    "airline_iata": airlineIata == null ? null : airlineIata,
    "lang": lang == null ? null : lang,
  };
}

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

  String? airlineIata;
  String? airlineIcao;
  String? flightNumber;
  String? flightIata;
  String? flightIcao;
  String? csAirlineIata;
  String? csFlightIata;
  String? csFlightNumber;
  String? depIata;
  String? depIcao;
  List<String>? depTerminals;
  String? depTime;
  String? depTimeUtc;
  String? arrIata;
  String? arrIcao;
  dynamic arrTerminals;
  String? arrTime;
  String? arrTimeUtc;
  int? duration;
  List<String>? days;
  dynamic aircraftIcao;
  int? counter;
  DateTime? updated;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    airlineIata: json["airline_iata"] == null ? null : json["airline_iata"],
    airlineIcao: json["airline_icao"] == null ? null : json["airline_icao"],
    flightNumber: json["flight_number"] == null ? null : json["flight_number"],
    flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
    flightIcao: json["flight_icao"] == null ? null : json["flight_icao"],
    csAirlineIata: json["cs_airline_iata"] == null ? null : json["cs_airline_iata"],
    csFlightIata: json["cs_flight_iata"] == null ? null : json["cs_flight_iata"],
    csFlightNumber: json["cs_flight_number"] == null ? null : json["cs_flight_number"],
    depIata: json["dep_iata"] == null ? null : json["dep_iata"],
    depIcao: json["dep_icao"] == null ? null : json["dep_icao"],
    depTerminals: json["dep_terminals"] == null ? null : List<String>.from(json["dep_terminals"].map((x) => x)),
    depTime: json["dep_time"] == null ? null : json["dep_time"],
    depTimeUtc: json["dep_time_utc"] == null ? null : json["dep_time_utc"],
    arrIata: json["arr_iata"] == null ? null : json["arr_iata"],
    arrIcao: json["arr_icao"] == null ? null : json["arr_icao"],
    arrTerminals: json["arr_terminals"],
    arrTime: json["arr_time"] == null ? null : json["arr_time"],
    arrTimeUtc: json["arr_time_utc"] == null ? null : json["arr_time_utc"],
    duration: json["duration"] == null ? null : json["duration"],
    days: json["days"] == null ? null : List<String>.from(json["days"].map((x) => x)),
    aircraftIcao: json["aircraft_icao"],
    counter: json["counter"] == null ? null : json["counter"],
    updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "airline_iata": airlineIata == null ? null : airlineIata,
    "airline_icao": airlineIcao == null ? null : airlineIcao,
    "flight_number": flightNumber == null ? null : flightNumber,
    "flight_iata": flightIata == null ? null : flightIata,
    "flight_icao": flightIcao == null ? null : flightIcao,
    "cs_airline_iata": csAirlineIata == null ? null : csAirlineIata,
    "cs_flight_iata": csFlightIata == null ? null : csFlightIata,
    "cs_flight_number": csFlightNumber == null ? null : csFlightNumber,
    "dep_iata": depIata == null ? null : depIata,
    "dep_icao": depIcao == null ? null : depIcao,
    "dep_terminals": depTerminals == null ? null : List<dynamic>.from(depTerminals!.map((x) => x)),
    "dep_time": depTime == null ? null : depTime,
    "dep_time_utc": depTimeUtc == null ? null : depTimeUtc,
    "arr_iata": arrIata == null ? null : arrIata,
    "arr_icao": arrIcao == null ? null : arrIcao,
    "arr_terminals": arrTerminals,
    "arr_time": arrTime == null ? null : arrTime,
    "arr_time_utc": arrTimeUtc == null ? null : arrTimeUtc,
    "duration": duration == null ? null : duration,
    "days": days == null ? null : List<dynamic>.from(days!.map((x) => x)),
    "aircraft_icao": aircraftIcao,
    "counter": counter == null ? null : counter,
    "updated": updated == null ? null : updated!.toIso8601String(),
  };
}
