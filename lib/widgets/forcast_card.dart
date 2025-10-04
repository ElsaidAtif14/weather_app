
import 'package:flutter/material.dart';
import 'package:weather/model/ForecastDay_model.dart';

class ForecastCard extends StatelessWidget {
  final Size size;
  final ForecastDay day;
  const ForecastCard({required this.size, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.92,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xff103F63), Color(0xff1A5276)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            // التاريخ والحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // تاريخ + حالة
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.date,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF6FAFF),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.condition,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffD9EFFF),
                      ),
                    ),
                  ],
                ),
                // أيقونة + درجات الحرارة
                Column(
                  children: [
                    Image.network(day.icon, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      "${day.maxTemp}° / ${day.minTemp}°",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffF6FAFF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // بيانات إضافية
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoData(value: day.maxWind, label: "Wind"),
                InfoData(value: day.avgHumidity, label: "Humidity"),
                InfoData(value: day.maxTemp, label: "Sunny"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoData extends StatelessWidget {
  final String value;
  final String label;
  const InfoData({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff38ACFF),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xffD9EFFF),
          ),
        ),
      ],
    );
  }
}
