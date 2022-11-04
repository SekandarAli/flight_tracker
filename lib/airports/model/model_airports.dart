// // To parse this JSON data, do
// //
// //     final modelAirports = modelAirportsFromJson(jsonString);
//
// import 'dart:convert';
//
// // ModelAirports modelAirportsFromJson(String str) => ModelAirports.fromJson(json.decode(str));
// //
// // String modelAirportsToJson(ModelAirports data) => json.encode(data.toJson());
//
//
// List<ModelAirports> modelAirportsFromJson(String str) => List<ModelAirports>.from(json.decode(str).map((x) => ModelAirports.fromJson(x)));
//
// String modelAirportsToJson(List<ModelAirports> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class ModelAirports {
//   ModelAirports({
//     this.pagination,
//     this.data,
//   });
//
//   Pagination? pagination;
//   List<Map<String, String>>? data;
//
//   factory ModelAirports.fromJson(Map<String, dynamic> json) => ModelAirports(
//     pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
//     data: json["data"] == null ? null : List<Map<String, String>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pagination": pagination == null ? null : pagination!.toJson(),
//     "data": data == null ? null : List<dynamic>.from(data!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
//   };
// }
//
// class Pagination {
//   Pagination({
//     this.offset,
//     this.limit,
//     this.count,
//     this.total,
//   });
//
//   int? offset;
//   int? limit;
//   int? count;
//   int? total;
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//     offset: json["offset"] == null ? null : json["offset"],
//     limit: json["limit"] == null ? null : json["limit"],
//     count: json["count"] == null ? null : json["count"],
//     total: json["total"] == null ? null : json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "offset": offset == null ? null : offset,
//     "limit": limit == null ? null : limit,
//     "count": count == null ? null : count,
//     "total": total == null ? null : total,
//   };
// }
