import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {

  // ignore: constant_identifier_names
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=Kochi&appid=$apiKey&units=metric') // Change the city
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(
        jsonDecode(response.body)
      );
    } else {
      throw Exception('Failed To Load Weather Data!');
    }
  }

  Future<String> getCurrentCity() async {
    // Get Permission From User
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get Current Location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high
      )
    );

    // Convert Location To Placemark Object
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude, 
      position.longitude,
    );

    // Exctract City Name
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}