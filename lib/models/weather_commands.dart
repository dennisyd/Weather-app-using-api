//===================================================================
// File: weather_commands.dart
//
// Desc: RxCommands for the Weather model.
//
// Copyright © 2019 Edwin Cloud. All rights reserved.
//===================================================================

//-------------------------------------------------------------------
// Imports
//-------------------------------------------------------------------
import 'package:rx_command/rx_command.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather.dart';

//-------------------------------------------------------------------
// WeatherCommands (Class) - Rx Commands for WeatherModel
//-------------------------------------------------------------------
class WeatherCommands {
  // class variables
  final WeatherRepository repo;
  final RxCommand<void, Position> updateLocationCommand;
  final RxCommand<Position, List<WeatherModel>> updateWeatherCommand;
  final RxCommand<void, bool> getGpsCommand;
  final RxCommand<bool, bool> radioCheckedCommand;
  final RxCommand<int, void> addCitiesCommand;

  // anonymous constructor (factory constructor will call to initialize
  // observable)
  WeatherCommands._(
      this.repo,
      this.updateLocationCommand,
      this.updateWeatherCommand,
      this.getGpsCommand,
      this.radioCheckedCommand,
      this.addCitiesCommand);

  // factory constructor
  factory WeatherCommands(WeatherRepository repo) {
    final _getGpsCommand =
        RxCommand.createAsyncNoParam<bool>(repo.getGps);
    final _radioCheckedCommand =
        RxCommand.createSync<bool, bool>((b) => b);
    final _updateLocationCommand =
        RxCommand.createAsyncNoParam<Position>(repo.updateLocation,
            canExecute: _getGpsCommand);
    final _updateWeatherCommand =
        RxCommand.createAsync<Position, List<WeatherModel>>(
            repo.updateWeather,
            canExecute: _radioCheckedCommand);
    final _addCitiesCommand =
        RxCommand.createSync<int, void>(repo.addCities);

    _updateLocationCommand
        .listen((data) => _updateWeatherCommand(data));

    _updateWeatherCommand(null);

    return WeatherCommands._(
        repo,
        _updateLocationCommand,
        _updateWeatherCommand,
        _getGpsCommand,
        _radioCheckedCommand,
        _addCitiesCommand);
  }
}
