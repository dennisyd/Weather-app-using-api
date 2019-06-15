// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
      message: json['message'] as String,
      cod: json['cod'] as String,
      count: json['count'] as int,
      cities: (json['list'] as List)
          ?.map((e) =>
              e == null ? null : City.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cod': instance.cod,
      'count': instance.count,
      'list': instance.cities
    };

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
      id: json['id'] as int,
      name: json['name'] as String,
      coord: json['coord'] == null
          ? null
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      dt: json['dt'] as int,
      wind: json['wind'] == null
          ? null
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      rain: json['rain'] == null
          ? null
          : Rain.fromJson(json['rain'] as Map<String, dynamic>),
      clouds: json['clouds'] == null
          ? null
          : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      weather: (json['weather'] as List)
          ?.map((e) =>
              e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'dt': instance.dt,
      'name': instance.name,
      'coord': instance.coord,
      'main': instance.main,
      'wind': instance.wind,
      'rain': instance.rain,
      'clouds': instance.clouds,
      'weather': instance.weather
    };

Coord _$CoordFromJson(Map<String, dynamic> json) {
  return Coord(
      lat: (json['lat'] as num)?.toDouble(),
      lon: (json['lon'] as num)?.toDouble());
}

Map<String, dynamic> _$CoordToJson(Coord instance) =>
    <String, dynamic>{'lat': instance.lat, 'lon': instance.lon};

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
      temp: (json['temp'] as num)?.toDouble(),
      pressure: (json['pressure'] as num)?.toDouble(),
      humidity: json['humidity'] as int,
      tempMax: (json['temp_max'] as num)?.toDouble(),
      tempMin: (json['temp_min'] as num)?.toDouble());
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'temp_max': instance.tempMax,
      'temp_min': instance.tempMin
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
      speed: (json['speed'] as num)?.toDouble(),
      deg: (json['deg'] as num)?.toDouble(),
      gust: (json['gust'] as num)?.toDouble());
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust
    };

Rain _$RainFromJson(Map<String, dynamic> json) {
  return Rain(threeHour: (json['3h'] as num)?.toDouble());
}

Map<String, dynamic> _$RainToJson(Rain instance) =>
    <String, dynamic>{'3h': instance.threeHour};

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return Clouds(all: json['all'] as int);
}

Map<String, dynamic> _$CloudsToJson(Clouds instance) =>
    <String, dynamic>{'all': instance.all};

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String);
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon
    };
