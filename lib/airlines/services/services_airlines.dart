import 'package:flight_tracker/airlines/model/model_airlines.dart';
import 'package:http/http.dart' as http;

class ServicesAirlines{
  Future<ModelAirlines> GetAllPosts() async{
    var url = Uri.parse("http://api.aviationstack.com/v1/airlines?access_key=71a77257dd833397c2b6856dceccc3e2");

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