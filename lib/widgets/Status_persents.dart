import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Statuspersents extends StatelessWidget {
  final String statue;
  final String persepent;
  final String statepersent;

  const Statuspersents({
    super.key,
    required this.statue,
    required this.persepent,
    required this.statepersent
  });

  IconData _getIcon(String statue) {
    switch (statue.toLowerCase()) {
      case "wind":
        return WeatherIcons.strong_wind;
      case "cloud":
        return WeatherIcons.cloud;
      case "humidity":
        return WeatherIcons.humidity;
      default:
        return Icons.help_outline; // fallback لو فيه قيمة غريبة
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff1B1E49).withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            _getIcon(statue),
            color: Colors.white,
            size: 28,
          ),
          Text(
            "$persepent$statepersent",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              overflow: TextOverflow.ellipsis
            ),
          ),
          Text(
            statue,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
