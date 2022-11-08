
import 'package:flight_tracker/airlines/model/model_airlines.dart';
import 'package:flight_tracker/airports/model/model_airport.dart';
import 'package:http/http.dart' as http;

class ServicesAirlines{
  Future<ModelAirlines> GetAllPosts() async{
    var url = Uri.parse("https://airlabs.co/api/v9/airlines?iata_code=AA&api_key=025436ad-1d42-4ab0-af01-62274e9bda5a");

    var response = await http.get(url);
    print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelAirlinesFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}