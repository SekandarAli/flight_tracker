import 'package:flight_tracker/airports/model/model_airports.dart';
import 'package:http/http.dart' as http;

import '../model/model_airport.dart';

class ServicesAirports{
  Future<ModelAirport> GetAllPosts() async{

    var url = Uri.parse("https://airlabs.co/api/v9/airports?iata_code=CDG&api_key=025436ad-1d42-4ab0-af01-62274e9bda5a");
    // var url = Uri.parse("https://app.goflightlabs.com/airports?access_key=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiMGEzYjI1M2I2YWQ0ODU4Yjk1NzNhNzZkYjZjMzVhZjE4YWNlNzEyOWIzYmY5YThhZDQ4NjExMTgxMTE0ODAxYTc5YmRiN2MxZjM1ODA2NDUiLCJpYXQiOjE2NjgwNzUyNzgsIm5iZiI6MTY2ODA3NTI3OCwiZXhwIjoxNjk5NjExMjc4LCJzdWIiOiIxNzYzNCIsInNjb3BlcyI6W119.byeY_7UUkT5vMeAXoc8kZnKdXhnCGACW5L_FcRZV5jQnRwrRq53bcUaJBOrHM792Fo0DoOTl_ONGXndVWUqZuw");

    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
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