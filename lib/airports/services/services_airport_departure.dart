import 'package:flight_tracker/airports/model/model_airport_dep_arr.dart';
import 'package:http/http.dart' as http;
import '../../api_key/api_key.dart';

class ServicesAirportsDeparture{

  Future<ModelAirportDepArr> GetAllPosts(String iataValue) async{

    var url = Uri.parse("https://airlabs.co/api/v9/schedules?dep_iata=$iataValue&api_key=${ApiKeys().API_KEY}");
    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelAirportDepArrFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}
