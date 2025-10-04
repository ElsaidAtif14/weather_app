class LocationModel {
  final String vallage;
  final String region;
  final String country;
  final String city;

  LocationModel( {
    required this.vallage,
    required this.region,
    required this.country,
    required this.city,
  });

  factory LocationModel.fromPlacemark(Map<String, String> place) {
    return LocationModel(
      vallage: place["vallage"] ?? "",
      region: place["region"] ?? "",
      country: place["country"] ?? "",
      city: place["city"]??""
    );
  }
}
