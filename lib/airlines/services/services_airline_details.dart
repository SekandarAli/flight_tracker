import 'package:flight_tracker/airlines/model/model_airline_detail.dart';
import 'package:http/http.dart' as http;
import '../../api_key/api_key.dart';

class ServicesAirlineDetails{

  Future<ModelAirlineDetails> GetAllPosts(String iataValue) async{

    var url = Uri.parse("https://airlabs.co/api/v9/routes?api_key=${ApiKeys().API_KEY}&airline_icao=$iataValue");
    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = ModelAirlineDetailsFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}
