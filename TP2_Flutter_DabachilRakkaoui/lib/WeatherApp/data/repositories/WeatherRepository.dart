import '../dataproviders/WeatherAPI.dart';
import '../models/ForecastModel.dart';
import '../models/WeatherModel.dart';

class WeatherRepository{
  final WeatherAPI api;

  WeatherRepository(this.api);

  Future<WeatherModel> getWeatherForLocation(String location) async {
    final String rawWeather = (await api.getCurrentWeather(cityName: location)) as String;
    final WeatherModel weather = weatherModelFromJson(rawWeather);
    return  weather;
  }

  Future<ForecastModel> getForecastsFromLatLon(double lat, double lon) async {
    final String rawForecast = (await api.getWeatherForecast(lat: lat, lon: lon)) as String;
    final ForecastModel weatherForecast = forecastModelFromJson(rawForecast);
    return  weatherForecast;
  }
}