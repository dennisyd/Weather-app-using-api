//===================================================================
// File: weather_provider.dart
//
// Desc: Weather Model state provider widget.
//
// Copyright © 2019 Edwin Cloud. All rights reserved.
//===================================================================

//-------------------------------------------------------------------
// Imports
//-------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/models/weather_commands.dart';

//-------------------------------------------------------------------
// WeatherProvider (Inherited Widget Class) - Weather Model Provider
//-------------------------------------------------------------------
class WeatherProvider extends InheritedWidget {
  // class variables
  final WeatherCommands weatherCommands;

  // constructor
  WeatherProvider(
      {Key key, @required this.weatherCommands, @required Widget child})
      : assert(weatherCommands != null),
        super(key: key, child: child);

  /// Returns [WeatherCommands] from passed in WeatherProvider child [context].
  static WeatherCommands of(BuildContext context) {
    WeatherProvider weatherProvider = context
        .inheritFromWidgetOfExactType(WeatherProvider) as WeatherProvider;
    return weatherProvider.weatherCommands;
  }

  /// Updates child widgets when [weatherCommands] has changed.
  @override
  bool updateShouldNotify(WeatherProvider oldWidget) {
    return weatherCommands != oldWidget.weatherCommands;
  }
}
