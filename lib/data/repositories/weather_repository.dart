import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/helpers/general_functions.dart';
import 'package:weather_app/res/strings.dart';

class WeatherRepository {
  //Future searchByName(String firstName);

  Future<Weather> getWeather() async {
    var url = '${AppStrings.weatherUrl}';

    var headers = await getHeaders();

    var response = await http.get(Uri.parse(url), headers: headers);

    String fileName = "cached.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/' + fileName);
    if (file.existsSync()) {
      //read from cache

      final data = file.readAsStringSync();

      final response = json.decode(data);

      final weather = Weather.fromJson(response);

      return weather;
    } else {
      if (response.statusCode == 200) {
        var body;

        body = json.decode(response.body);

        Weather weather = Weather.fromJson(body);

        return weather;
      } else {
        json.decode(response.body);
      }
    }
  }
}
