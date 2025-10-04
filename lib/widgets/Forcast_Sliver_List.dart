
import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';

class ForcastSliverList extends StatelessWidget {
  const ForcastSliverList({
    super.key,
    required this.weather,
  });

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final day = weather.forecast[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff103F63),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.network(
                    day.icon,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 12),
    
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day.date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          day.condition,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
    
                  Text(
                    "${day.maxTemp}° / ${day.minTemp}°",
                    style: const TextStyle(
                      color: Color(0xff38ACFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: weather.forecast.length,
      ),
    );
  }
}
