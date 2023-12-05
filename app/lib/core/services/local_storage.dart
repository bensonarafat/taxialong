import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  void setGeoLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('geolocaton', true);
  }

  Future<bool?> getEnableLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool("geolocation");

    if (status == null) return null;

    return status;
  }
}
