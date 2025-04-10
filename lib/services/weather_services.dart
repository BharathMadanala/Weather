import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather_model.dart';

class WeatherServices {
  // ignore: constant_identifier_names
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  WeatherServices(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&apiKey=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
    //function checks if the app has permission to access the device’s location. (e.g., granted, denied, restricted).
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //gives location in latitute and longitude
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter:
            100, // Minimum distance (in meters) before update is triggered
      ),
    );

    //function converts latitude and longitude into address details like city, country, street name,etc. (placemarks[0]) usually contains the most relevant address.

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? city = placemarks[0].locality;

    return city ?? "";

    //fetch user's location

    //
  }
}
