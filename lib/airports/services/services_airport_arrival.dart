import 'package:flight_tracker/airports/model/model_airport_arrival.dart';
import 'package:http/http.dart' as http;
import '../../api_key/api_key.dart';
import '../model/model_airport_departure.dart';

class ServicesAirportsArrival{

  Future<ModelAirportArrival> GetAllPosts(String iataValue) async{

    var url = Uri.parse("https://airlabs.co/api/v9/schedules?arr_iata=$iataValue&api_key=${ApiKeys().API_KEY}");
    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelAirportArrivalFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}