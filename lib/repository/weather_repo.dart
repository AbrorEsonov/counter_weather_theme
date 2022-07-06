import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../service/error_handler.dart';
import '../service/exceptions/weather_exception.dart';

class WeatherRepository{

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.


      return false;
    }

    permission = await GeolocatorPlatform.instance.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance.requestPermission();
      if (permission == LocationPermission.denied) {

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriatel

      return false;
    }

    return true;
  }

    Future<Position?> getPosition() async {
      final hasPermission = await _handlePermission();

      if (hasPermission) {
        final Position position = await GeolocatorPlatform.instance.getCurrentPosition();
        return position;
      }

      return null;


  }

  Future<String> getAll(){
    return getPosition().then((value){
     return  getData(value!.latitude, value.longitude);
    });
  }

  Future<String> getData(double latitude, double longitude) async {
    // String api = 'http://api.openweathermap.org/data/2.5/forecast';
    // String appId = 'e3725d376b14c16ce46f7ee5d18db6af';

    // String url = '$api?lat=$latitude&lon=$longitude&APPID=$appId';
    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '$latitude',
        'lon': '$longitude',
        'appid': 'e3725d376b14c16ce46f7ee5d18db6af',
      },
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        log(response.body);
        final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Cannot get the weather of the city');
        }

        return "${responseBody['weather'][0]['description']} ${responseBody['name']}";
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }


}