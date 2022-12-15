import 'package:http/http.dart' as http;
import '../../api_key/api_key.dart';
import '../model/model_search_flight.dart';


class ServicesSearchFlight{
  Future<ModelSearchFlight> GetAllPosts(
      {required String depIata, required String arrIata, required String airlineIcao,required String flightIata,required String day}) async{

    var url = Uri.parse(
        "https://airlabs.co/api/v9/routes?api_key=${ApiKeys().API_KEY}&dep_iata=$depIata&arr_iata=$arrIata&airline_icao=$airlineIcao&flight_iata=$flightIata&days=$day");

    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelSearchFlightFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}