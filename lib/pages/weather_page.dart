import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _weatherService = WeatherServices(
    apiKey: dotenv.env['API_KEY'] ?? 'error',
  );
  Weather? _weather;

  // Fetch Weather
  _fetchWeather() async {
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
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 1.2 * kToolbarHeight, 30, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Background
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),

              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF673AB7),
                  ),
                ),
              ),

              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 900,
                  decoration: BoxDecoration(color: Color(0xFFFFAB40)),
                ),
              ),

              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 300.0, sigmaY: 100.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),

              // -------------------------------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/location.png', height: 20),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),

                      // City Name
                      Text(
                        _weather?.cityName ?? "City..",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),

                  Text(
                    "Good Morning",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: media.height * 0.05),

                  // Animated Image
                  Center(
                    child: Lottie.asset(
                      getWeatherAnimation(_weather?.mainCondition),
                    ),
                  ),

                  SizedBox(height: media.height * 0.05),

                  // Temperature
                  Center(
                    child: Text(
                      '${_weather?.temp.round()} °C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 5),

                  // Weather Condition
                  Center(
                    child: Text(
                      _weather?.mainCondition.toUpperCase() ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 5),

                  // Time And Day Info
                  Center(
                    child: Text(
                      'Wednesday 20\t\t\t|\t\t\t12:00 AM',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white60
                      ),
                    ),
                  ),

                  SizedBox(height: media.height * 0.05),

                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // City Name
//             Text(
//               _weather?.cityName ?? "City.."
//             ),

//             // Animation
//             Lottie.asset(
//               getWeatherAnimation(_weather?.mainCondition)
//             ),
        
//             // Temperature
//             Text(
//               '${_weather?.temp.round()} °C' 
//             ),

//             // Weather Condition
//             Text(
//               _weather?.mainCondition ?? ""
//             ),
//           ],
//         ),
//       ),