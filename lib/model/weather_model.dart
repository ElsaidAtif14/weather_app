import 'package:weather/model/Current_wether.dart';
import 'package:weather/model/ForecastDay_model.dart';
import 'package:weather/model/location_model.dart';

class WeatherModel {
  final CurrentWeather current;
  final LocationWeather location;
  final List<ForecastDay> forecast;

  WeatherModel({
    required this.current,
    required this.location,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      current: CurrentWeather.fromJson(json),
      location: LocationWeather.fromJson(json),
      forecast: (json['forecast']['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList(),
    );
  }
}
