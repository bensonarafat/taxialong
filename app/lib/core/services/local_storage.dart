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

  void setDriverMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('driverMode', true);
  }

  Future<bool> getDriverMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool("driverMode");
    if (status == null) return false;
    return status;
  }
}
