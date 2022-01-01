import 'dart:convert';

import 'package:flutter_application_11/model.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final queryParameter = {
      "q": city,
      'appid': "14a3880e714cc42351903221abc79d63",
      'units': 'imperial'
    };
    final Url =
        Uri.https("https://api.openweathermap.org/", "data/2.5/weather");
    var response = await http.get(Url);
    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
