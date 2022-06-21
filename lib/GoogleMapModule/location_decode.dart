import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

fetchLocationName(LatLng latLng) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latLng.latitude, latLng.longitude,localeIdentifier: "UR");
  print("placemarks");
  print(placemarks);
  print(placemarks.first);
}
