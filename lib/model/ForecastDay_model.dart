class ForecastDay {
  final String date;
  final String maxTemp;
  final String minTemp;
  final String condition;
  final String icon;
  final String maxWind;
  final String avgHumidity;

  ForecastDay({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.icon,
    required this.maxWind,
    required this.avgHumidity,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    final day = json['day'];
    final condition = day['condition'];

    return ForecastDay(
      date: json['date'],
      maxTemp: day['maxtemp_c'].toString(),
      minTemp: day['mintemp_c'].toString(),
      condition: condition['text'],
      icon: "https:${condition['icon']}",
      maxWind: day['maxwind_kph'].toString(),    
      avgHumidity: day['avghumidity'].toString(), 
    );
  }
}
