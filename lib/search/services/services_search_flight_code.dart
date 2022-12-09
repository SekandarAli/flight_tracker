// import 'package:flight_tracker/search/model/model_search_flight_code.dart';
// import 'package:http/http.dart' as http;
//
// import '../../api_key/api_key.dart';
//
//
// class ServicesSearchFlights{
//   Future<ModelSearchFlights> GetAllPosts() async{
//
//     var url = Uri.parse("https://airlabs.co/api/v9/flights?api_key=${ApiKeys().API_KEY}");
//
//     var response = await http.get(url);
//     // print("Response status: ${response.statusCode}");
//     // print("Response body: ${response.body}");
//
//     if(response.statusCode == 200){
//       final modelData = modelSearchFlightsFromJson(response.body.toString());
//       return modelData;
//     }
//     else{
//       throw Exception('Failed to load Data');
//     }
//   }
// }