import 'package:flight_tracker/airlines/model/model_airline_detail.dart';
import 'package:http/http.dart' as http;
import '../../api_key/api_key.dart';
import 'model.dart';

class ServicesCityName{

  Future<ModelCityName> GetAllPosts(String cityCode) async{

    var url = Uri.parse("https://airlabs.co/api/v9/cities?api_key=${ApiKeys().API_KEY}&city_code=$cityCode");
    var response = await http.get(url);
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if(response.statusCode == 200){
      final modelData = modelCityNameFromJson(response.body.toString());
      return modelData;
    }
    else{
      throw Exception('Failed to load Data');
    }
  }
}
