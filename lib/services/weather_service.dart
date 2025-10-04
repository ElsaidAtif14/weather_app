import 'package:dio/dio.dart';
import 'package:weather/model/location_service_model.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/location_service.dart';

class WeatherService {
  final Dio dio = Dio();
  final String baseUrl = "https://api.weatherapi.com/v1/forecast.json";
  final String apiKey = "8b842bcbe3024b15856112015252809";

  Future<WeatherModel> getWeather({String? countryOrCity}) async {
    String query;

    if (countryOrCity != null && countryOrCity.isNotEmpty) {
      query = countryOrCity;
    } else {
      LocationModel locModel = await LocationService().getUserLocation();
      query = locModel.city;
    }

    String url = "$baseUrl?key=$apiKey&q=$query&days=7&aqi=no&alerts=no";
    final response = await dio.get(url);
    WeatherModel weather = WeatherModel.fromJson(response.data);
    return weather;
  }
}
