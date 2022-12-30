import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<String> {

  String _city = "Montpellier";

  WeatherCubit() : super("Montpellier");

  set city(String city) {
    _city = city;
  }
}
