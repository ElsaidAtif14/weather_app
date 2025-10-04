class CurrentWeather {
  final String imageurl;
  final DateTime date;
  final String temprature;
  final String cloud;
  final String humidity;
  final String wind;
  final String condition;

  CurrentWeather({
    required this.imageurl,
    required this.date,
    required this.temprature,
    required this.cloud,
    required this.humidity,
    required this.wind,
    required this.condition
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    final condition = current['condition'] as Map<String, dynamic>;

    return CurrentWeather(
      imageurl: "https:${condition['icon']}",
      date: DateTime.parse(current['last_updated']),
      temprature: current['temp_c'].toString(),
      cloud: current['cloud'].toString(),
      humidity: current['humidity'].toString(),
      wind: current['wind_kph'].toString(),
      condition: condition['text']
    );
  }
}
