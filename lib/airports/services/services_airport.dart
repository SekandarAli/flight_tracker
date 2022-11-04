// import 'dart:convert';
//
// import 'package:flight_tracker/airports/model/model_airports.dart';
// import 'package:http/http.dart' as http;
//
// class ServicesAirports{
//   Future<List<ModelAirports>> getAllPosts() async{
//     var modelData;
//     var url = Uri.parse("http://api.aviationstack.com/v1/airports?access_key=71a77257dd833397c2b6856dceccc3e2");
//
//     var response = await http.get(url);
//     print("Response status: ${response.statusCode}");
//     // print("Response body: ${response.body}");
//
//     if(response.statusCode == 200){
//       // print("aa111a${modelData}");
//
//       final modelData = modelAirportsFromJson(response.body.toString());
//       return modelData;
//
//
//       // var jsonResponse = jsonDecode(response.body.toString());
//       //
//       // // print("aa111a${jsonResponse}");
//       //
//       // var modelDatata = ModelAirports.fromJson(jsonResponse);
//       //
//       // final parsed = json.decode(response.body);
//       //
//       // print("aa111a1212${parsed}");
//       //
//       // return parsed.map<ModelAirports>((json) => ModelAirports.fromJson(json)).toList();
//
//       // return(jsonResponse);
//       // return ModelAirports.fromJson(jsonResponse);
//
//
//       // modelData = modelAirportsFromJson(response.body);
//       // print("aaa${modelData}");
//       // return modelData;
//     }
//     else{
//       throw Exception('Failed to load Data');
//     }
//   }
//
//
//
//
//
//
//   // Future<List<ModelAirports>> fetchPost() async {
//   //   final response =
//   //   await http.get(Uri.parse('http://api.aviationstack.com/v1/airports?access_key=71a77257dd833397c2b6856dceccc3e2'));
//   //
//   //   if (response.statusCode == 200) {
//   //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//   //
//   //     return parsed.map<ModelAirports>((json) => ModelAirports.fromJson(json)).toList();
//   //   } else {
//   //     throw Exception('Failed to load album');
//   //   }
//   // }
// }