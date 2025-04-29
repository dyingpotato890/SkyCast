import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json'; // Default
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';

      case 'thunderstorm':
        return 'assets/thunder.json';
      
      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

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

            // Animation
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition)
            ),
        
            // Temperature
            Text(
              '${_weather?.temp.round()} °C' 
            ),

            // Weather Condition
            Text(
              _weather?.mainCondition ?? ""
            ),
          ],
        ),
      ),
    );
  }
}