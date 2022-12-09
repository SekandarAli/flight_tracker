// // To parse this JSON data, do
// //
// //     final modelSearchFlights = modelSearchFlightsFromJson(jsonString);
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
