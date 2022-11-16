// To parse this JSON data, do
//
//     final modelSearchFlights = modelSearchFlightsFromJson(jsonString);

import 'dart:convert';

ModelSearchFlights modelSearchFlightsFromJson(String str) => ModelSearchFlights.fromJson(json.decode(str));

String modelSearchFlightsToJson(ModelSearchFlights data) => json.encode(data.toJson());

class ModelSearchFlights {
  ModelSearchFlights({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  List<Datum>? data;

  factory ModelSearchFlights.fromJson(Map<String, dynamic> json) => ModelSearchFlights(
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
    this.flightDate,
    this.flightStatus,
    this.departure,
    this.arrival,
    this.airline,
    this.flight,
    this.aircraft,
    this.live,
  });

  DateTime? flightDate;
  FlightStatus? flightStatus;
  Arrival? departure;
  Arrival? arrival;
  Airline? airline;
  Flight? flight;
  dynamic aircraft;
  dynamic live;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    flightDate: json["flight_date"] == null ? null : DateTime.parse(json["flight_date"]),
    flightStatus: json["flight_status"] == null ? null : flightStatusValues.map![json["flight_status"]],
    departure: json["departure"] == null ? null : Arrival.fromJson(json["departure"]),
    arrival: json["arrival"] == null ? null : Arrival.fromJson(json["arrival"]),
    airline: json["airline"] == null ? null : Airline.fromJson(json["airline"]),
    flight: json["flight"] == null ? null : Flight.fromJson(json["flight"]),
    aircraft: json["aircraft"],
    live: json["live"],
  );

  Map<String, dynamic> toJson() => {
    "flight_date": flightDate == null ? null : "${flightDate!.year.toString().padLeft(4, '0')}-${flightDate!.month.toString().padLeft(2, '0')}-${flightDate!.day.toString().padLeft(2, '0')}",
    "flight_status": flightStatus == null ? null : flightStatusValues.reverse[flightStatus],
    "departure": departure == null ? null : departure!.toJson(),
    "arrival": arrival == null ? null : arrival!.toJson(),
    "airline": airline == null ? null : airline!.toJson(),
    "flight": flight == null ? null : flight!.toJson(),
    "aircraft": aircraft,
    "live": live,
  };
}

class Airline {
  Airline({
    this.name,
    this.iata,
    this.icao,
  });

  String? name;
  String? iata;
  String? icao;

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
    name: json["name"] == null ? null : json["name"],
    iata: json["iata"] == null ? null : json["iata"],
    icao: json["icao"] == null ? null : json["icao"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "iata": iata == null ? null : iata,
    "icao": icao == null ? null : icao,
  };
}

class Arrival {
  Arrival({
    this.airport,
    this.timezone,
    this.iata,
    this.icao,
    this.terminal,
    this.gate,
    this.baggage,
    this.delay,
    this.scheduled,
    this.estimated,
    this.actual,
    this.estimatedRunway,
    this.actualRunway,
  });

  String? airport;
  String? timezone;
  String? iata;
  String? icao;
  String? terminal;
  String? gate;
  String? baggage;
  int? delay;
  DateTime? scheduled;
  DateTime? estimated;
  DateTime? actual;
  DateTime? estimatedRunway;
  DateTime? actualRunway;

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
    airport: json["airport"] == null ? null : json["airport"],
    timezone: json["timezone"] == null ? null : json["timezone"],
    iata: json["iata"] == null ? null : json["iata"],
    icao: json["icao"] == null ? null : json["icao"],
    terminal: json["terminal"] == null ? null : json["terminal"],
    gate: json["gate"] == null ? null : json["gate"],
    baggage: json["baggage"] == null ? null : json["baggage"],
    delay: json["delay"] == null ? null : json["delay"],
    scheduled: json["scheduled"] == null ? null : DateTime.parse(json["scheduled"]),
    estimated: json["estimated"] == null ? null : DateTime.parse(json["estimated"]),
    actual: json["actual"] == null ? null : DateTime.parse(json["actual"]),
    estimatedRunway: json["estimated_runway"] == null ? null : DateTime.parse(json["estimated_runway"]),
    actualRunway: json["actual_runway"] == null ? null : DateTime.parse(json["actual_runway"]),
  );

  Map<String, dynamic> toJson() => {
    "airport": airport == null ? null : airport,
    "timezone": timezone == null ? null : timezone,
    "iata": iata == null ? null : iata,
    "icao": icao == null ? null : icao,
    "terminal": terminal == null ? null : terminal,
    "gate": gate == null ? null : gate,
    "baggage": baggage == null ? null : baggage,
    "delay": delay == null ? null : delay,
    "scheduled": scheduled == null ? null : scheduled!.toIso8601String(),
    "estimated": estimated == null ? null : estimated!.toIso8601String(),
    "actual": actual == null ? null : actual!.toIso8601String(),
    "estimated_runway": estimatedRunway == null ? null : estimatedRunway!.toIso8601String(),
    "actual_runway": actualRunway == null ? null : actualRunway!.toIso8601String(),
  };
}

class Flight {
  Flight({
    this.number,
    this.iata,
    this.icao,
    this.codeshared,
  });

  String? number;
  String? iata;
  String? icao;
  Codeshared? codeshared;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
    number: json["number"] == null ? null : json["number"],
    iata: json["iata"] == null ? null : json["iata"],
    icao: json["icao"] == null ? null : json["icao"],
    codeshared: json["codeshared"] == null ? null : Codeshared.fromJson(json["codeshared"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number == null ? null : number,
    "iata": iata == null ? null : iata,
    "icao": icao == null ? null : icao,
    "codeshared": codeshared == null ? null : codeshared!.toJson(),
  };
}

class Codeshared {
  Codeshared({
    this.airlineName,
    this.airlineIata,
    this.airlineIcao,
    this.flightNumber,
    this.flightIata,
    this.flightIcao,
  });

  String? airlineName;
  String? airlineIata;
  String? airlineIcao;
  String? flightNumber;
  String? flightIata;
  String? flightIcao;

  factory Codeshared.fromJson(Map<String, dynamic> json) => Codeshared(
    airlineName: json["airline_name"] == null ? null : json["airline_name"],
    airlineIata: json["airline_iata"] == null ? null : json["airline_iata"],
    airlineIcao: json["airline_icao"] == null ? null : json["airline_icao"],
    flightNumber: json["flight_number"] == null ? null : json["flight_number"],
    flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
    flightIcao: json["flight_icao"] == null ? null : json["flight_icao"],
  );

  Map<String, dynamic> toJson() => {
    "airline_name": airlineName == null ? null : airlineName,
    "airline_iata": airlineIata == null ? null : airlineIata,
    "airline_icao": airlineIcao == null ? null : airlineIcao,
    "flight_number": flightNumber == null ? null : flightNumber,
    "flight_iata": flightIata == null ? null : flightIata,
    "flight_icao": flightIcao == null ? null : flightIcao,
  };
}

enum FlightStatus { SCHEDULED, ACTIVE, CANCELLED, LANDED }

final flightStatusValues = EnumValues({
  "active": FlightStatus.ACTIVE,
  "cancelled": FlightStatus.CANCELLED,
  "landed": FlightStatus.LANDED,
  "scheduled": FlightStatus.SCHEDULED
});

class Pagination {
  Pagination({
    this.limit,
    this.offset,
    this.count,
    this.total,
  });

  int? limit;
  int? offset;
  int? count;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    limit: json["limit"] == null ? null : json["limit"],
    offset: json["offset"] == null ? null : json["offset"],
    count: json["count"] == null ? null : json["count"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit == null ? null : limit,
    "offset": offset == null ? null : offset,
    "count": count == null ? null : count,
    "total": total == null ? null : total,
  };
}

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


// To parse this JSON data, do
//
//     final modelSearchFlights = modelSearchFlightsFromJson(jsonString);
//
// import 'dart:convert';
//
// ModelSearchFlights modelSearchFlightsFromJson(String str) => ModelSearchFlights.fromJson(json.decode(str));
//
// String modelSearchFlightsToJson(ModelSearchFlights data) => json.encode(data.toJson());
//
// class ModelSearchFlights {
//   ModelSearchFlights({
//     this.request,
//     this.response,
//     this.terms,
//   });
//
//   Request? request;
//   List<Response>? response;
//   String? terms;
//
//   factory ModelSearchFlights.fromJson(Map<String, dynamic> json) => ModelSearchFlights(
//     request: json["request"] == null ? null : Request.fromJson(json["request"]),
//     response: json["response"] == null ? null : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
//     terms: json["terms"] == null ? null : json["terms"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "request": request == null ? null : request!.toJson(),
//     "response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
//     "terms": terms == null ? null : terms,
//   };
// }
//
// class Request {
//   Request({
//     this.lang,
//     this.currency,
//     this.time,
//     this.id,
//     this.server,
//     this.host,
//     this.pid,
//     this.key,
//     this.params,
//     this.version,
//     this.method,
//     this.client,
//   });
//
//   String? lang;
//   String? currency;
//   int? time;
//   String? id;
//   String? server;
//   String? host;
//   int? pid;
//   Key? key;
//   Params? params;
//   int? version;
//   String? method;
//   Client? client;
//
//   factory Request.fromJson(Map<String, dynamic> json) => Request(
//     lang: json["lang"] == null ? null : json["lang"],
//     currency: json["currency"] == null ? null : json["currency"],
//     time: json["time"] == null ? null : json["time"],
//     id: json["id"] == null ? null : json["id"],
//     server: json["server"] == null ? null : json["server"],
//     host: json["host"] == null ? null : json["host"],
//     pid: json["pid"] == null ? null : json["pid"],
//     key: json["key"] == null ? null : Key.fromJson(json["key"]),
//     params: json["params"] == null ? null : Params.fromJson(json["params"]),
//     version: json["version"] == null ? null : json["version"],
//     method: json["method"] == null ? null : json["method"],
//     client: json["client"] == null ? null : Client.fromJson(json["client"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lang": lang == null ? null : lang,
//     "currency": currency == null ? null : currency,
//     "time": time == null ? null : time,
//     "id": id == null ? null : id,
//     "server": server == null ? null : server,
//     "host": host == null ? null : host,
//     "pid": pid == null ? null : pid,
//     "key": key == null ? null : key!.toJson(),
//     "params": params == null ? null : params!.toJson(),
//     "version": version == null ? null : version,
//     "method": method == null ? null : method,
//     "client": client == null ? null : client!.toJson(),
//   };
// }
//
// class Client {
//   Client({
//     this.ip,
//     this.geo,
//     this.connection,
//     this.device,
//     this.agent,
//     this.karma,
//   });
//
//   String? ip;
//   Geo? geo;
//   Connection? connection;
//   Agent? device;
//   Agent? agent;
//   Karma? karma;
//
//   factory Client.fromJson(Map<String, dynamic> json) => Client(
//     ip: json["ip"] == null ? null : json["ip"],
//     geo: json["geo"] == null ? null : Geo.fromJson(json["geo"]),
//     connection: json["connection"] == null ? null : Connection.fromJson(json["connection"]),
//     device: json["device"] == null ? null : Agent.fromJson(json["device"]),
//     agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
//     karma: json["karma"] == null ? null : Karma.fromJson(json["karma"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ip": ip == null ? null : ip,
//     "geo": geo == null ? null : geo!.toJson(),
//     "connection": connection == null ? null : connection!.toJson(),
//     "device": device == null ? null : device!.toJson(),
//     "agent": agent == null ? null : agent!.toJson(),
//     "karma": karma == null ? null : karma!.toJson(),
//   };
// }
//
// class Agent {
//   Agent();
//
//   factory Agent.fromJson(Map<String, dynamic> json) => Agent(
//   );
//
//   Map<String, dynamic> toJson() => {
//   };
// }
//
// class Connection {
//   Connection({
//     this.type,
//   });
//
//   String? type;
//
//   factory Connection.fromJson(Map<String, dynamic> json) => Connection(
//     type: json["type"] == null ? null : json["type"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "type": type == null ? null : type,
//   };
// }
//
// class Geo {
//   Geo({
//     this.countryCode,
//     this.country,
//     this.continent,
//     this.city,
//     this.lat,
//     this.lng,
//     this.timezone,
//   });
//
//   String? countryCode;
//   String? country;
//   String? continent;
//   String? city;
//   double? lat;
//   double? lng;
//   String? timezone;
//
//   factory Geo.fromJson(Map<String, dynamic> json) => Geo(
//     countryCode: json["country_code"] == null ? null : json["country_code"],
//     country: json["country"] == null ? null : json["country"],
//     continent: json["continent"] == null ? null : json["continent"],
//     city: json["city"] == null ? null : json["city"],
//     lat: json["lat"] == null ? null : json["lat"].toDouble(),
//     lng: json["lng"] == null ? null : json["lng"].toDouble(),
//     timezone: json["timezone"] == null ? null : json["timezone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "country_code": countryCode == null ? null : countryCode,
//     "country": country == null ? null : country,
//     "continent": continent == null ? null : continent,
//     "city": city == null ? null : city,
//     "lat": lat == null ? null : lat,
//     "lng": lng == null ? null : lng,
//     "timezone": timezone == null ? null : timezone,
//   };
// }
//
// class Karma {
//   Karma({
//     this.isBlocked,
//     this.isCrawler,
//     this.isBot,
//     this.isFriend,
//     this.isRegular,
//   });
//
//   bool? isBlocked;
//   bool? isCrawler;
//   bool? isBot;
//   bool? isFriend;
//   bool? isRegular;
//
//   factory Karma.fromJson(Map<String, dynamic> json) => Karma(
//     isBlocked: json["is_blocked"] == null ? null : json["is_blocked"],
//     isCrawler: json["is_crawler"] == null ? null : json["is_crawler"],
//     isBot: json["is_bot"] == null ? null : json["is_bot"],
//     isFriend: json["is_friend"] == null ? null : json["is_friend"],
//     isRegular: json["is_regular"] == null ? null : json["is_regular"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "is_blocked": isBlocked == null ? null : isBlocked,
//     "is_crawler": isCrawler == null ? null : isCrawler,
//     "is_bot": isBot == null ? null : isBot,
//     "is_friend": isFriend == null ? null : isFriend,
//     "is_regular": isRegular == null ? null : isRegular,
//   };
// }
//
// class Key {
//   Key({
//     this.id,
//     this.apiKey,
//     this.type,
//     this.expired,
//     this.registered,
//     this.limitsByHour,
//     this.limitsByMinute,
//     this.limitsByMonth,
//     this.limitsTotal,
//   });
//
//   int? id;
//   String? apiKey;
//   String? type;
//   DateTime? expired;
//   DateTime? registered;
//   int? limitsByHour;
//   int? limitsByMinute;
//   int? limitsByMonth;
//   int? limitsTotal;
//
//   factory Key.fromJson(Map<String, dynamic> json) => Key(
//     id: json["id"] == null ? null : json["id"],
//     apiKey: json["api_key"] == null ? null : json["api_key"],
//     type: json["type"] == null ? null : json["type"],
//     expired: json["expired"] == null ? null : DateTime.parse(json["expired"]),
//     registered: json["registered"] == null ? null : DateTime.parse(json["registered"]),
//     limitsByHour: json["limits_by_hour"] == null ? null : json["limits_by_hour"],
//     limitsByMinute: json["limits_by_minute"] == null ? null : json["limits_by_minute"],
//     limitsByMonth: json["limits_by_month"] == null ? null : json["limits_by_month"],
//     limitsTotal: json["limits_total"] == null ? null : json["limits_total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "api_key": apiKey == null ? null : apiKey,
//     "type": type == null ? null : type,
//     "expired": expired == null ? null : expired!.toIso8601String(),
//     "registered": registered == null ? null : registered!.toIso8601String(),
//     "limits_by_hour": limitsByHour == null ? null : limitsByHour,
//     "limits_by_minute": limitsByMinute == null ? null : limitsByMinute,
//     "limits_by_month": limitsByMonth == null ? null : limitsByMonth,
//     "limits_total": limitsTotal == null ? null : limitsTotal,
//   };
// }
//
// class Params {
//   Params({
//     this.lang,
//   });
//
//   String? lang;
//
//   factory Params.fromJson(Map<String, dynamic> json) => Params(
//     lang: json["lang"] == null ? null : json["lang"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lang": lang == null ? null : lang,
//   };
// }
//
// class Response {
//   Response({
//     this.hex,
//     this.regNumber,
//     this.flag,
//     this.lat,
//     this.lng,
//     this.alt,
//     this.dir,
//     this.speed,
//     this.vSpeed,
//     this.squawk,
//     this.flightNumber,
//     this.flightIcao,
//     this.flightIata,
//     this.depIcao,
//     this.depIata,
//     this.arrIcao,
//     this.arrIata,
//     this.airlineIcao,
//     this.airlineIata,
//     this.aircraftIcao,
//     this.updated,
//     this.status,
//   });
//
//   String? hex;
//   String? regNumber;
//   String? flag;
//   double? lat;
//   double? lng;
//   int? alt;
//   int? dir;
//   int? speed;
//   double? vSpeed;
//   String? squawk;
//   String? flightNumber;
//   String? flightIcao;
//   String? flightIata;
//   String? depIcao;
//   String? depIata;
//   String? arrIcao;
//   String? arrIata;
//   String? airlineIcao;
//   String? airlineIata;
//   String? aircraftIcao;
//   int? updated;
//   Status? status;
//
//   factory Response.fromJson(Map<String, dynamic> json) => Response(
//     hex: json["hex"] == null ? null : json["hex"],
//     regNumber: json["reg_number"] == null ? null : json["reg_number"],
//     flag: json["flag"] == null ? null : json["flag"],
//     lat: json["lat"] == null ? null : json["lat"].toDouble(),
//     lng: json["lng"] == null ? null : json["lng"].toDouble(),
//     alt: json["alt"] == null ? null : json["alt"],
//     dir: json["dir"] == null ? null : json["dir"],
//     speed: json["speed"] == null ? null : json["speed"],
//     vSpeed: json["v_speed"] == null ? null : json["v_speed"].toDouble(),
//     squawk: json["squawk"] == null ? null : json["squawk"],
//     flightNumber: json["flight_number"] == null ? null : json["flight_number"],
//     flightIcao: json["flight_icao"] == null ? null : json["flight_icao"],
//     flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
//     depIcao: json["dep_icao"] == null ? null : json["dep_icao"],
//     depIata: json["dep_iata"] == null ? null : json["dep_iata"],
//     arrIcao: json["arr_icao"] == null ? null : json["arr_icao"],
//     arrIata: json["arr_iata"] == null ? null : json["arr_iata"],
//     airlineIcao: json["airline_icao"] == null ? null : json["airline_icao"],
//     airlineIata: json["airline_iata"] == null ? null : json["airline_iata"],
//     aircraftIcao: json["aircraft_icao"] == null ? null : json["aircraft_icao"],
//     updated: json["updated"] == null ? null : json["updated"],
//     status: json["status"] == null ? null : statusValues.map![json["status"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "hex": hex == null ? null : hex,
//     "reg_number": regNumber == null ? null : regNumber,
//     "flag": flag == null ? null : flag,
//     "lat": lat == null ? null : lat,
//     "lng": lng == null ? null : lng,
//     "alt": alt == null ? null : alt,
//     "dir": dir == null ? null : dir,
//     "speed": speed == null ? null : speed,
//     "v_speed": vSpeed == null ? null : vSpeed,
//     "squawk": squawk == null ? null : squawk,
//     "flight_number": flightNumber == null ? null : flightNumber,
//     "flight_icao": flightIcao == null ? null : flightIcao,
//     "flight_iata": flightIata == null ? null : flightIata,
//     "dep_icao": depIcao == null ? null : depIcao,
//     "dep_iata": depIata == null ? null : depIata,
//     "arr_icao": arrIcao == null ? null : arrIcao,
//     "arr_iata": arrIata == null ? null : arrIata,
//     "airline_icao": airlineIcao == null ? null : airlineIcao,
//     "airline_iata": airlineIata == null ? null : airlineIata,
//     "aircraft_icao": aircraftIcao == null ? null : aircraftIcao,
//     "updated": updated == null ? null : updated,
//     "status": status == null ? null : statusValues.reverse[status],
//   };
// }
//
// enum Status { EN_ROUTE, LANDED, SCHEDULED }
//
// final statusValues = EnumValues({
//   "en-route": Status.EN_ROUTE,
//   "landed": Status.LANDED,
//   "scheduled": Status.SCHEDULED
// });
//
// class EnumValues<T> {
//   Map<String, T>? map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map!.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
