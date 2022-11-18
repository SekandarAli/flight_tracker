import 'package:http/http.dart' as http;
import '../model/model_airport.dart';

class ServicesAirports{
  Future<ModelAirport> GetAllPosts() async{

    // var url = Uri.parse("https://airlabs.co/api/v9/airports?api_key=725f85e9-850a-4e4e-bbb6-cc8371d0ab54");
    var url = Uri.parse("https://airlabs.co/api/v9/airports?api_key=725f85e9-850a-4e4e-bbb6-cc8371d0ab54&country_code=ES&country_code=IN&country_code=NL&country_code=CN&country_code=MX&country_code=PK");
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
