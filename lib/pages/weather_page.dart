import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  // Api Key
  final _weatherService = WeatherServices(apiKey: dotenv.env['API_KEY'] ?? 'error');
  Weather? _weather;
  
  // Fetch Weather
  _fetchWeather () async {
    // Get Current City
    String cityName = await _weatherService.getCurrentCity();
    print('City: $cityName');

    // Get Weather For City
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // Error Handling
    catch (e) {
      print(e);
    }
  }

  // Weather Animations


  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City Name
            Text(
              _weather?.cityName ?? "City.."
            ),
        
            // Temperature
            Text(
              '${_weather?.temp.round()} °C' 
            ),
          ],
        ),
      ),
    );
  }
}