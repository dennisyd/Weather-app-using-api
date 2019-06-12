//===================================================================
// File: weather.dart
//
// Desc: Weather model data access methods.
//
// Copyright © 2019 Edwin Cloud. All rights reserved.
//===================================================================

//-------------------------------------------------------------------
// Imports
//-------------------------------------------------------------------
import 'dart:async';
import 'dart:convert';
import 'package:weather_app/json/response.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/api_key.dart' show API_KEY;
import 'package:geolocator/geolocator.dart';

//-------------------------------------------------------------------
// WeatherRepository (Class) - Weather Repository
//-------------------------------------------------------------------
class WeatherRepository {
  // class variables
  final http.Client client;
  int cnt = 50;

  // constructor
  WeatherRepository({
    this.client,
  });

  /// Updates city count for API request.
  void addCities(int count) {
    cnt = count;
  }

  /// Makes a request to OpenWeatherApi for weather information surrounding
  /// given [position]. Returns a Future<List<WeatherModel>>.
  Future<List<WeatherModel>> updateWeather(Position position) async {
    String url;
    if (position != null) {
      url =
          "http://api.openweathermap.org/data/2.5/find?lat=${position.latitude.toString()}&lon=${position.longitude.toString()}&cnt=$cnt&appid=$API_KEY";
    } else {
      url =
          "http://api.openweathermap.org/data/2.5/find?lat=55.5&lon=37.5&cnt=$cnt&appid=$API_KEY";
    }

    final response = await client.get(url);

    List<WeatherModel> req = BaseResponse.fromJson(json.decode(response.body))
        .cities
        .map((city) => WeatherModel.fromResponse(city))
        .toList();

    return req;
  }

  /// Gets last known position using Geolocator plugin. Returns a Future<Position>.
  Future<Position> updateLocation() {
    // will return null if no location last
    return Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  /// Gets the status of Location Permissions for the Geolocator plugin. Returns a Future<bool>.
  Future<bool> getGps() async {
    final GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted) return true;
    return false;
  }
}
