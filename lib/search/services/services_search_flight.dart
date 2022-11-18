import 'package:flight_tracker/search/model/model_search_flights.dart';
import 'package:http/http.dart' as http;


class ServicesSearchFlights{
  Future<ModelSearchFlights> GetAllPosts() async{

    var url = Uri.parse("https://airlabs.co/api/v9/flights?api_key=725f85e9-850a-4e4e-bbb6-cc8371d0ab54");

    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelSearchFlightsFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}