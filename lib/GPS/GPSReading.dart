import 'package:geolocator/geolocator.dart';

class GPSReading{

  static Future<List<String>> getLocation() async {
    final geoLocator = Geolocator();
    final isLocationEnabled = await geoLocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      final locationData = await geoLocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
//      final placeMarkData = await geoLocator.placemarkFromCoordinates(
//          locationData.latitude, locationData.longitude);

      List<String> latlongData = [];
      latlongData.add(locationData.latitude.toString());
      latlongData.add(locationData.longitude.toString());
//      latlongData.add(placeMarkData[0].subAdministrativeArea ?? "");
//      latlongData.add(placeMarkData[0].administrativeArea ?? "");
//      latlongData.add(placeMarkData[0].country ?? "");
      return latlongData;
    }
  }
}