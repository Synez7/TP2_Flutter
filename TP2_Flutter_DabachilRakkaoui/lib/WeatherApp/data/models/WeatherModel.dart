

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

class WeatherModel {

  late double lat;
  late double lon;
  late String cityName;
  late String countryName;
  late String weatherIcon;
  late String description;

  late double temp;

  late int humidity;
  late double wind;
  late int pressure;

  WeatherModel(
      this.lat,
      this.lon,
      this.cityName,
      this.countryName,
      this.weatherIcon,
      this.description,
      this.temp,
      this.humidity,
      this.wind,
      this.pressure);




    WeatherModel.fromJson(Map<String, dynamic> json) {

      lat = json['coord']['lat'];
      lon = json['coord']['lon'];

      cityName = json['name'];
    countryName = json['sys']['country'];
    weatherIcon = json['weather'][0]['main'];
    description = json['weather'][0]['description'];
    temp = json['main']['temp'];
    humidity =  json['main']['humidity'];
    wind =  json['wind']['speed'];
    pressure =  json['main']['pressure'];

  }






  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['coord']['lat'] = lat;
    data['coord']['lon'] = lon;
    data['name'] = cityName;
    data['sys']['country'] = countryName;
    data['weather']['main'] = weatherIcon;
    data['weather'][0]['descritpion'] = description;
    data['main']['temp'] = temp;
    data['main']['humidity'] = humidity;
    data['wind']['speed'] = wind;
    data['main']['pressure'] = pressure;

    return data;
  }



}

class Coord {
  late double lon;
  late double lat;

  Coord(this.lon, this.lat);

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['coord']['lon'] != null ? json['coord']['lon'].toDouble() : 0;
    lat = json['coord']['lat'] != null ? json['coord']['lat'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coord']['lon'] = lon;
    data['coord']['lat'] = lat;

    return data;
  }



}

class Sys {
  late num type;
  late num id;
  late String country;
  late num sunrise;
  late num sunset;

  Sys(this.type, this.id, this.country, this.sunrise, this.sunset);

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? 0;
    id = json['id'] ?? 0;
    country = json['country'] ?? "";
    sunrise = json['sunrise'] ?? 0;
    sunset = json['sunset'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;

    return data;
  }
}

class Weather {
  late num id;
  late String main;
  late String description;
  late String icon;

  Weather(this.id, this.main, this.description, this.icon);

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    main = json['main'] ?? "";
    description = json['description'] ?? "";
    icon = json['icon'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;

    return data;
  }
}

