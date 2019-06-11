//===================================================================
// File: weather.dart
//
// Desc: Weather Model
//
// Copyright © 2019 Edwin Cloud. All rights reserved.
//===================================================================

import 'package:weather_app/json/response.dart';

class Weather {
  final String city, description;
  final double temperature, rain, lat, long;

  Weather(
      {this.city,
      this.description,
      this.temperature,
      this.rain,
      this.lat,
      this.long});

  Weather.fromResponse(City response)
      : city = response.name,
        temperature = response.main.temp,
        description = response.weather[0].description,
        rain = response.rain.threeHour,
        lat = response.coord.lat,
        long = response.coord.long;
}
