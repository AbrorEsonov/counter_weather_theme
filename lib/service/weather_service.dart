import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'error_handler.dart';
import 'exceptions/weather_exception.dart';
import 'model/weather_model.dart';

class WeatherApiServices {
  Future<Weather> getWeather(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      queryParameters: {
        'q': city,
        'appid': 'e3725d376b14c16ce46f7ee5d18db6af',
      },
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        log(response.body);
        late final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Cannot get the weather of the city');
        }

        return Weather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }
}