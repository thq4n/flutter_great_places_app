import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static String generatePreviewImageUrl(
      {required double latitude, required double longitude}) {
    String apiKey =
        "pk.eyJ1IjoidGhpZXVxdWFuNTAxIiwiYSI6ImNrcjdvcjVmdjE0OW8ycG52azBjdGJ1cm0ifQ.MEUOFikPEwuS4AQM6W1u9A";
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,16.5,0,0/600x300?access_token=$apiKey";
  }

  static Future<String> generatePreviewAddress(
      {required double latitude, required double longitude}) async {
    final apiKey =
        "pk.eyJ1IjoidGhpZXVxdWFuNTAxIiwiYSI6ImNrcjdvcjVmdjE0OW8ycG52azBjdGJ1cm0ifQ.MEUOFikPEwuS4AQM6W1u9A";
    final getGeocodeingAPIUrl = Uri.parse(
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude%2C%20$latitude.json?access_token=$apiKey");

    var locationResponse = await http.get(getGeocodeingAPIUrl);
    var locationData =
        json.decode(locationResponse.body) as Map<String, dynamic>;

    if ((locationData["features"] as List).isEmpty) {
      return "";
    }

    return (locationData["features"] as List).first["place_name"].toString();
  }
}
