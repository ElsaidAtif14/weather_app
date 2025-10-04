import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/model/location_service_model.dart';

class LocationService {
  Future<LocationModel> getUserLocation() async {
    // 1- اطلب الصلاحيات
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission permanently denied");
    }

    // 2- جيب الإحداثيات
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 3- جيب العنوان من الإحداثيات
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];

    return LocationModel(
      vallage: place.locality ?? "",
      region: place.administrativeArea ?? "",
      country: place.country ?? "",
      city: place.subAdministrativeArea??""

    );
  }
}
