import 'package:flight_tracker/flight_detail/model/model_airport_track_screen.dart';
import 'package:http/http.dart' as http;
import '../../api_key/api_key.dart';

class ServicesAirportsTrackScreen{
  Future<ModelAirportTrackScreen> GetAllPosts(String flight_iata) async{

    var url = Uri.parse("https://airlabs.co/api/v9/flight?flight_iata=$flight_iata&api_key=${ApiKeys().API_KEY}");
    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelAirportTrackScreenFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}
