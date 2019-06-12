//===================================================================
// File: weather.dart
//
// Desc: Weather Model
//
// Copyright © 2019 Edwin Cloud. All rights reserved.
//===================================================================

//-------------------------------------------------------------------
// Imports
//-------------------------------------------------------------------
import 'package:weather_app/json/response.dart';

//-------------------------------------------------------------------
// WeatherModel (Class) - Weather Model
//-------------------------------------------------------------------
class WeatherModel {
  // class variables
  final String city, description;
  final double temperature, rain, lat, long;

  // constructor
  WeatherModel(
      {this.city,
      this.description,
      this.temperature,
      this.rain,
      this.lat,
      this.long});

  /// Creates a new WeatherModel from a City [response].
  WeatherModel.fromResponse(City response)
      : city = response.name,
        temperature = response.main.temp,
        description = response.weather[0].description,
        rain = response.rain.threeHour,
        lat = response.coord.lat,
        long = response.coord.long;
}
