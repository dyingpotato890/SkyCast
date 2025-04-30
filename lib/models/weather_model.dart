class Weather {
  final String cityName;
  final double windSpeed;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final double pressure;
  final double humidity;
  final int sunrise;
  final int sunset;
  final String mainCondition;

  Weather ({
    required this.cityName,
    required this.windSpeed,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.pressure,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {

    return Weather(
      cityName: json['name'],
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      temp: json['main']['temp'].toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      mainCondition: json['weather'][0]['main'],
    );
  }
}