import 'dart:convert';
  ForecastModel forecastModelFromJson(String str) => ForecastModel.fromJson(json.decode(str));

class ForecastModel {

  late List<Forecast> forecastList;
  late City city;

  ForecastModel(
      this.forecastList,
      this.city
      );



  ForecastModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      forecastList = [];
      json['list'].forEach((v) {
        forecastList.add(Forecast.fromJson(v));
      });
    }

    city = json['city'] != null ? City.fromJson(json['city']) : City(0,
        "",Coordo(0,0),"",0,0,0,0);

  }





  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['list'] = forecastList.map((v) => v.toJson()).toList();
    data['city'] = city.toJson();

    return data;
  }




}


class Forecast{


  late num dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late num visibility;
  late num pop;
  late Sys sys;
  late String dt_txt;

  Forecast(this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop,
      this.sys,
      this.dt_txt);


  Forecast.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] ?? 0;
    main = json['main'] != null ? Main.fromJson(json['main']) : Main(0.0,0.0,0.0,0.0,0,0,0,0,0.0);
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'] != null  ? Clouds.fromJson(json['clouds']) : Clouds(0);
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : Wind(0,0,0);
    visibility = json['visibility'] ?? 0;
    pop = json['pop'] ?? 0;
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : Sys('');
    dt_txt = json['dt_txt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['main'] = main;
    data['weather'] = weather.map((v) => v.toJson()).toList();
    data['clouds'] = clouds;
    data['wind'] = wind;
    data['visibility'] = visibility;
    data['pop'] = pop;
    data['sys'] = sys;
    data['dt_txt'] = dt_txt;


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
  late String pod;


  Sys(this.pod);

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pod'] = pod;

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



class Rain {
  late num d1h;
  late num d3h;

  Rain(this.d3h, this.d1h);

  Rain.fromJson(Map<String, dynamic> json) {
    d3h = json['3h'] != null ? json['3h'].toDouble() : 0;
    d1h = json['1h'] != null ? json['1h'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['3h'] = d3h;
    data['1h'] = d1h;

    return data;
  }
}


class Clouds {
  late num all;

  Clouds(this.all);

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;

    return data;
  }
}

class Wind {
  late num speed;
  late num deg;
  late num gust;

  Wind(this.speed, this.deg, this.gust);

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'] != null ? json['speed'].toDouble() : 0;
    deg = json['deg'] ?? 0;
    gust = json['gust'] != null ? json['gust'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;

    return data;
  }
}

class Main {
  late num temp;
  late num feelsLike;
  late num tempMin;
  late num tempMax;
  late num pressure;
  late num seaLevel;
  late num grndLevel;
  late num humidity;
  late num tempKf;


  Main(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure,
      this.seaLevel,this.grndLevel,this.humidity,this.tempKf);

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? json['temp'].toDouble() : 0;
    feelsLike = json['feels_like'] != null ? json['feels_like'].toDouble() : 0;
    tempMin = json['temp_min'] != null ? json['temp_min'].toDouble() : 0;
    tempMax = json['temp_max'] != null ? json['temp_max'].toDouble() : 0;
    pressure = json['pressure'] ?? 0;
    seaLevel = json['sea_level'] ?? 0;
    grndLevel = json['grnd_level'] ?? 0;
    humidity = json['humidity'] ?? 0;
    tempKf = json['temp_kf']  != null ? json['temp_kf'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;
    data['temp_kf'] = tempKf;

    return data;
  }
}

class Coordo {
  late num lon;
  late num lat;

  Coordo(this.lon, this.lat);

  Coordo.fromJson(Map<String, dynamic> json) {
    lon = json['lon'] != null ? json['lon'].toDouble() : 0;
    lat = json['lat'] != null ? json['lat'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}

class City {
  late num id;
  late String name;
  late Coordo coord;
  late String country;
  late num population;
  late num timezone;
  late num sunrise;
  late num sunset;

  City(this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset);

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    coord = json['coord'] != null ? Coordo.fromJson(json['coord']) : Coordo(0, 0);
    country = json['country'] ?? "";
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['coord'] = coord;
    data['country'] = coord;
    data['population'] = coord;
    data['timezone'] = coord;
    data['sunrise'] = coord;
    data['sunset'] = coord;

    return data;
  }
}





