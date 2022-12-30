import 'dart:convert';
import 'package:http/http.dart';
import '../../utils/Utils.dart';
import '../models/ForecastModel.dart';
import '../models/WeatherModel.dart';


class WeatherAPI {

  // Evaluation d'une requête retournant les infos de la météo du jour
  // pour une ville donnée
  Future<WeatherModel?> getCurrentWeather({required String cityName}) async {
    var url = "${Utils.API_URL}/weather?q=$cityName&appid=${Utils.API_KEY}&lang=FR";
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting current weather");
    }
  }

  // Evaluation d'une requête retournant les infos des prévisions météo
  // pour les sept jours qui suivent la date courante selon la ville recherchée
  Future<ForecastModel?> getWeatherForecast(
      {required double lon, required double lat}) async {
    var url =
        "${Utils.API_URL}/forecast?lat=$lat&lon=$lon&appid=${Utils.API_KEY}";
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception("Error getting weather forecast");
    }
  }
}
