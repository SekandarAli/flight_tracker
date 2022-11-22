import 'package:flight_tracker/airlines/model/model_airlines.dart';
import 'package:http/http.dart' as http;

import '../../api_key/api_key.dart';

class ServicesAirlines{
  Future<ModelAirlines> GetAllPosts() async{
    var url = Uri.parse("https://airlabs.co/api/v9/airlines?api_key=${ApiKeys().API_KEY}");

    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
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