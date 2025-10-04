import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/widgets/Fancy_Spinner.dart';
import 'package:weather/widgets/Weather_card.dart';

class WeatherCardViewBuilder extends StatefulWidget {
  const WeatherCardViewBuilder({super.key, this.contry});
  final String? contry;

  @override
  State<WeatherCardViewBuilder> createState() => _WeatherCardViewBuilderState();
}

class _WeatherCardViewBuilderState extends State<WeatherCardViewBuilder> {
  late Future<WeatherModel> _futureWeather;

  @override
  void initState() {
    super.initState();
    _futureWeather =
        WeatherService().getWeather(countryOrCity: widget.contry);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherModel>(
      future: _futureWeather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: FancySpinner());
        }

        if (snapshot.hasError) {
          return Center(
            child: Lottie.asset('Assets/animation/no internet.json'),
          );
        }

        if (snapshot.hasData) {
          final weather = snapshot.data!;
          return WeatherCard(model: weather, contry: widget.contry);
        }

        return const Center(
          child: Text("No data", style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}
