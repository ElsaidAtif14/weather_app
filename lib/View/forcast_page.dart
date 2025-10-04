// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/widgets/Forcast_Sliver_List.dart';
import 'package:weather/widgets/forcast_card.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff04082D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "7-Day Forecast",
          style: TextStyle(
            color: Color(0xffF6FAFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // ====== العنوان + ليست أفقية ======
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Next 7 days ",
                    style: TextStyle(
                      color: Color(0xffF6FAFF),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 190,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weather.forecast.length,
                      itemBuilder: (context, index) {
                        final day = weather.forecast[index];
                        return ForecastCard(size: size, day: day);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ForcastSliverList(weather: weather),
        ],
      ),
    );
  }
}
