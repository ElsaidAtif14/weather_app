class LocationWeather {
  final String name;
  final String country;
  final String region;

  LocationWeather({
    required this.name,
    required this.country,
    required this.region,
  });

  factory LocationWeather.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>;
    return LocationWeather(
      name: location['name'],
      country: location['country'],
      region: location['region'],
    );
  }
}
