// To parse this JSON data, do
//
//     final modelAirportTrackScreen = modelAirportTrackScreenFromJson(jsonString);

import 'dart:convert';

ModelAirportTrackScreen modelAirportTrackScreenFromJson(String str) => ModelAirportTrackScreen.fromJson(json.decode(str));

String modelAirportTrackScreenToJson(ModelAirportTrackScreen data) => json.encode(data.toJson());

class ModelAirportTrackScreen {
  ModelAirportTrackScreen({
    this.request,
    this.response,
    this.terms,
  });

  Request? request;
  Response? response;
  String? terms;

  factory ModelAirportTrackScreen.fromJson(Map<String, dynamic> json) => ModelAirportTrackScreen(
    request: json["request"] == null ? null : Request.fromJson(json["request"]),
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
    terms: json["terms"] == null ? null : json["terms"],
  );

  Map<String, dynamic> toJson() => {
    "request": request == null ? null : request!.toJson(),
    "response": response == null ? null : response!.toJson(),
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
    this.flightIata,
    this.lang,
  });

  String? flightIata;
  String? lang;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
    lang: json["lang"] == null ? null : json["lang"],
  );

  Map<String, dynamic> toJson() => {
    "flight_iata": flightIata == null ? null : flightIata,
    "lang": lang == null ? null : lang,
  };
}

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
    this.depEstimated,
    this.depActual,
    this.depTimeUtc,
    this.depEstimatedUtc,
    this.depActualUtc,
    this.depTimeTs,
    this.depEstimatedTs,
    this.depActualTs,
    this.arrIata,
    this.arrIcao,
    this.arrTerminal,
    this.arrGate,
    this.arrBaggage,
    this.arrTime,
    this.arrEstimated,
    this.arrActual,
    this.arrTimeUtc,
    this.arrEstimatedUtc,
    this.arrActualUtc,
    this.arrTimeTs,
    this.arrEstimatedTs,
    this.arrActualTs,
    this.csAirlineIata,
    this.csFlightNumber,
    this.csFlightIata,
    this.regNumber,
    this.status,
    this.duration,
    this.delayed,
    this.depDelayed,
    this.arrDelayed,
    this.updated,
    this.depName,
    this.depCity,
    this.depCountry,
    this.arrName,
    this.arrCity,
    this.arrCountry,
    this.airlineName,
    this.flag,
    this.percent,
    this.utc,
  });

  String? airlineIata;
  String? airlineIcao;
  String? flightIata;
  String? flightIcao;
  String? flightNumber;
  String? depIata;
  String? depIcao;
  String? depTerminal;
  String? depGate;
  String? depTime;
  String? depEstimated;
  String? depActual;
  String? depTimeUtc;
  String? depEstimatedUtc;
  String? depActualUtc;
  int? depTimeTs;
  int? depEstimatedTs;
  int? depActualTs;
  String? arrIata;
  String? arrIcao;
  String? arrTerminal;
  String? arrGate;
  String? arrBaggage;
  String? arrTime;
  String? arrEstimated;
  String? arrActual;
  String? arrTimeUtc;
  String? arrEstimatedUtc;
  String? arrActualUtc;
  int? arrTimeTs;
  int? arrEstimatedTs;
  int? arrActualTs;
  String? csAirlineIata;
  String? csFlightNumber;
  String? csFlightIata;
  dynamic regNumber;
  String? status;
  int? duration;
  dynamic delayed;
  dynamic depDelayed;
  dynamic arrDelayed;
  int? updated;
  String? depName;
  String? depCity;
  String? depCountry;
  String? arrName;
  String? arrCity;
  String? arrCountry;
  String? airlineName;
  String? flag;
  int? percent;
  String? utc;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    airlineIata: json["airline_iata"] == null ? null : json["airline_iata"],
    airlineIcao: json["airline_icao"] == null ? null : json["airline_icao"],
    flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
    flightIcao: json["flight_icao"] == null ? null : json["flight_icao"],
    flightNumber: json["flight_number"] == null ? null : json["flight_number"],
    depIata: json["dep_iata"] == null ? null : json["dep_iata"],
    depIcao: json["dep_icao"] == null ? null : json["dep_icao"],
    depTerminal: json["dep_terminal"] == null ? null : json["dep_terminal"],
    depGate: json["dep_gate"] == null ? null : json["dep_gate"],
    depTime: json["dep_time"] == null ? null : json["dep_time"],
    depEstimated: json["dep_estimated"] == null ? null : json["dep_estimated"],
    depActual: json["dep_actual"] == null ? null : json["dep_actual"],
    depTimeUtc: json["dep_time_utc"] == null ? null : json["dep_time_utc"],
    depEstimatedUtc: json["dep_estimated_utc"] == null ? null : json["dep_estimated_utc"],
    depActualUtc: json["dep_actual_utc"] == null ? null : json["dep_actual_utc"],
    depTimeTs: json["dep_time_ts"] == null ? null : json["dep_time_ts"],
    depEstimatedTs: json["dep_estimated_ts"] == null ? null : json["dep_estimated_ts"],
    depActualTs: json["dep_actual_ts"] == null ? null : json["dep_actual_ts"],
    arrIata: json["arr_iata"] == null ? null : json["arr_iata"],
    arrIcao: json["arr_icao"] == null ? null : json["arr_icao"],
    arrTerminal: json["arr_terminal"] == null ? null : json["arr_terminal"],
    arrGate: json["arr_gate"] == null ? null : json["arr_gate"],
    arrBaggage: json["arr_baggage"] == null ? null : json["arr_baggage"],
    arrTime: json["arr_time"] == null ? null : json["arr_time"],
    arrEstimated: json["arr_estimated"] == null ? null : json["arr_estimated"],
    arrActual: json["arr_actual"] == null ? null : json["arr_actual"],
    arrTimeUtc: json["arr_time_utc"] == null ? null : json["arr_time_utc"],
    arrEstimatedUtc: json["arr_estimated_utc"] == null ? null : json["arr_estimated_utc"],
    arrActualUtc: json["arr_actual_utc"] == null ? null : json["arr_actual_utc"],
    arrTimeTs: json["arr_time_ts"] == null ? null : json["arr_time_ts"],
    arrEstimatedTs: json["arr_estimated_ts"] == null ? null : json["arr_estimated_ts"],
    arrActualTs: json["arr_actual_ts"] == null ? null : json["arr_actual_ts"],
    csAirlineIata: json["cs_airline_iata"] == null ? null : json["cs_airline_iata"],
    csFlightNumber: json["cs_flight_number"] == null ? null : json["cs_flight_number"],
    csFlightIata: json["cs_flight_iata"] == null ? null : json["cs_flight_iata"],
    regNumber: json["reg_number"],
    status: json["status"] == null ? null : json["status"],
    duration: json["duration"] == null ? null : json["duration"],
    delayed: json["delayed"],
    depDelayed: json["dep_delayed"],
    arrDelayed: json["arr_delayed"],
    updated: json["updated"] == null ? null : json["updated"],
    depName: json["dep_name"] == null ? null : json["dep_name"],
    depCity: json["dep_city"] == null ? null : json["dep_city"],
    depCountry: json["dep_country"] == null ? null : json["dep_country"],
    arrName: json["arr_name"] == null ? null : json["arr_name"],
    arrCity: json["arr_city"] == null ? null : json["arr_city"],
    arrCountry: json["arr_country"] == null ? null : json["arr_country"],
    airlineName: json["airline_name"] == null ? null : json["airline_name"],
    flag: json["flag"] == null ? null : json["flag"],
    percent: json["percent"] == null ? null : json["percent"],
    utc: json["utc"] == null ? null : json["utc"],
  );

  Map<String, dynamic> toJson() => {
    "airline_iata": airlineIata == null ? null : airlineIata,
    "airline_icao": airlineIcao == null ? null : airlineIcao,
    "flight_iata": flightIata == null ? null : flightIata,
    "flight_icao": flightIcao == null ? null : flightIcao,
    "flight_number": flightNumber == null ? null : flightNumber,
    "dep_iata": depIata == null ? null : depIata,
    "dep_icao": depIcao == null ? null : depIcao,
    "dep_terminal": depTerminal == null ? null : depTerminal,
    "dep_gate": depGate == null ? null : depGate,
    "dep_time": depTime == null ? null : depTime,
    "dep_estimated": depEstimated == null ? null : depEstimated,
    "dep_actual": depActual == null ? null : depActual,
    "dep_time_utc": depTimeUtc == null ? null : depTimeUtc,
    "dep_estimated_utc": depEstimatedUtc == null ? null : depEstimatedUtc,
    "dep_actual_utc": depActualUtc == null ? null : depActualUtc,
    "dep_time_ts": depTimeTs == null ? null : depTimeTs,
    "dep_estimated_ts": depEstimatedTs == null ? null : depEstimatedTs,
    "dep_actual_ts": depActualTs == null ? null : depActualTs,
    "arr_iata": arrIata == null ? null : arrIata,
    "arr_icao": arrIcao == null ? null : arrIcao,
    "arr_terminal": arrTerminal == null ? null : arrTerminal,
    "arr_gate": arrGate == null ? null : arrGate,
    "arr_baggage": arrBaggage == null ? null : arrBaggage,
    "arr_time": arrTime == null ? null : arrTime,
    "arr_estimated": arrEstimated == null ? null : arrEstimated,
    "arr_actual": arrActual == null ? null : arrActual,
    "arr_time_utc": arrTimeUtc == null ? null : arrTimeUtc,
    "arr_estimated_utc": arrEstimatedUtc == null ? null : arrEstimatedUtc,
    "arr_actual_utc": arrActualUtc == null ? null : arrActualUtc,
    "arr_time_ts": arrTimeTs == null ? null : arrTimeTs,
    "arr_estimated_ts": arrEstimatedTs == null ? null : arrEstimatedTs,
    "arr_actual_ts": arrActualTs == null ? null : arrActualTs,
    "cs_airline_iata": csAirlineIata == null ? null : csAirlineIata,
    "cs_flight_number": csFlightNumber == null ? null : csFlightNumber,
    "cs_flight_iata": csFlightIata == null ? null : csFlightIata,
    "reg_number": regNumber,
    "status": status == null ? null : status,
    "duration": duration == null ? null : duration,
    "delayed": delayed,
    "dep_delayed": depDelayed,
    "arr_delayed": arrDelayed,
    "updated": updated == null ? null : updated,
    "dep_name": depName == null ? null : depName,
    "dep_city": depCity == null ? null : depCity,
    "dep_country": depCountry == null ? null : depCountry,
    "arr_name": arrName == null ? null : arrName,
    "arr_city": arrCity == null ? null : arrCity,
    "arr_country": arrCountry == null ? null : arrCountry,
    "airline_name": airlineName == null ? null : airlineName,
    "flag": flag == null ? null : flag,
    "percent": percent == null ? null : percent,
    "utc": utc == null ? null : utc,
  };
}
