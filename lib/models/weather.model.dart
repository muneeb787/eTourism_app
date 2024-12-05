import 'temperature.model.dart';

class WeatherModel {
  final String main;
  final String description;
  final TemperatureModel temperature;
  final int humidity;
  final int windSpeed;
  final String cityName;

  WeatherModel({
    required this.main,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.cityName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      main: json['main'] as String,
      description: json['description'] as String,
      temperature: TemperatureModel.fromJson(json['temperature'] as Map<String, dynamic>),
      humidity: json['humidity'] as int,
      windSpeed: json['windSpeed'] as int,
      cityName: json['cityName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      'description': description,
      'temperature': temperature.toJson(),
      'humidity': humidity,
      'windSpeed': windSpeed,
      'cityName': cityName,
    };
  }
}