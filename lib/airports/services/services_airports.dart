
import 'package:flight_tracker/airports/model/model_airport.dart';
import 'package:http/http.dart' as http;

class ServicesAirports{
  Future<ModelAirport> GetAllPosts() async{
    var url = Uri.parse("https://airlabs.co/api/v9/airports?iata_code=CDG&api_key=025436ad-1d42-4ab0-af01-62274e9bda5a");

    var response = await http.get(url);
    print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelAirportFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}