import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../business_logic/cubits/WeatherCubit.dart';
import '../../data/dataproviders/WeatherAPI.dart';
import '../../data/models/ForecastModel.dart';
import '../../data/models/WeatherModel.dart';
import '../../utils/Utils.dart';
import '../widgets/loading_widget.dart';
import '../widgets/weatherIcon_widget.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool _iconBool = false; // indicateur si mode sombre activé ou non

// Icône de changement de thème pour l'appli Météo présente
// sur l'extrémité droite de l'AppBar
IconData _iconLight = Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;



class _MyHomePageState extends State<MyHomePage> {
  late final _formatDate;
  final _textController = TextEditingController();
  final _weatherAPI = WeatherAPI();


  // Initialisation du modèle Weather
  WeatherModel _dataWeather = WeatherModel(
      0.0,
      0.0,
      "",
      "",
      "",
      "",
      0.0,
      0,
      0.0,
      0);

  // Initialisation du modèle Forecast
  ForecastModel _dataForecast = ForecastModel([],City(0,"",
      Coordo(0,0),"",0,0,0,0));



  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _formatDate = DateFormat('EEEE d MMMM y, H:mm', 'fr');
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _iconBool ? Color(0xff383434) : Colors.blue,
            title: Text("Weather App", style: TextStyle(
                color: Colors.white
            ),),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _iconBool = !_iconBool;
                  });
                },
                icon: Icon(_iconBool ? _iconDark : _iconLight),
              )
            ],
          ),
          backgroundColor: _iconBool ? Color(0xff383434) : Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: _textController,
                    style: TextStyle(
                        color: _iconBool ? Colors.white : Colors.black),
                    //<-- SEE HERE
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: _iconBool
                            ? Color(0xff68fcdc)
                            : Colors.grey),

                      ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: _iconBool ? Colors.amber
                            : Colors.grey),

                      ),
                      prefixIcon: Icon(Icons.search,
                        color: _iconBool ? Color(0xff68fcdc) : Colors.grey,),
                      hintText: "Entrer le nom d'une ville",
                      hintStyle: TextStyle(
                          color: _iconBool ? Colors.white : Colors.black),
                    ),
                    onSubmitted: (value) {
                      context.read<WeatherCubit>().emit(value);
                    },
                  ),
                  BlocBuilder<WeatherCubit, String>(builder: (context, city) {
                    return FutureBuilder<WeatherModel?>(
                        future: _weatherAPI.getCurrentWeather(cityName: city),
                        builder: (context, snapshot) {
                          if (!snapshot.hasError &&
                              snapshot.hasData &&
                              _dataWeather != snapshot.data) {
                            _dataWeather = snapshot.data!;
                            return WeatherWidget();
                          }
                          else if (snapshot.hasError || !snapshot.hasData) {
                            return MissingForecastsWidget(
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.8);
                          }
                          else {
                            return LoadingWidget(
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.8);
                          }
                        });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Widget présentant les infos de la météo du jour pour une ville donnée
  Widget WeatherWidget() {
    String _date = _formatDate.format(DateTime.now());
    _date = _date[0].toUpperCase() + _date.substring(1);

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: ' ${_dataWeather.cityName.toUpperCase()}, ${_dataWeather.countryName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  color: _iconBool ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          _date,
          style: TextStyle(
            color: _iconBool ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 2,
          constraints: BoxConstraints(
            maxWidth: 281,
            maxHeight: MediaQuery
                .of(context)
                .size
                .height / 2.5,
          ),
          child: getWeatherIcon(weather: _dataWeather.weatherIcon,
              color: _iconBool ? Color(0xff68fcdc) : Colors.pink,
              size: 170),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${Utils.toCelsius(_dataWeather.temp)}°C',
              style: TextStyle(
                //fontSize: 40,
                fontSize: 40,
                fontWeight: FontWeight.w400,
                //fontWeight: FontWeight.bold,
                color: _iconBool ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(_dataWeather.description.toUpperCase(), style:
            TextStyle(color: _iconBool ? Colors.white : Colors.black)),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80.0, right: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${Utils.toKmh(_dataWeather.wind)} km/h',
                    style: TextStyle(
                        color: _iconBool ? Colors.white : Colors.black)
                    ,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Icon(
                    FontAwesomeIcons.wind,
                    color: _iconBool ? Colors.amber : Colors.brown,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${_dataWeather.humidity}%',
                      style: TextStyle(
                          color: _iconBool ? Colors.white : Colors.black)
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Icon(
                    FontAwesomeIcons.grinBeamSweat,
                    color: _iconBool ? Colors.amber : Colors.brown,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${Utils.toCelsius(_dataWeather.temp)}°C',
                      style: TextStyle(
                          color: _iconBool ? Colors.white : Colors.black)

                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Icon(
                    FontAwesomeIcons.temperatureHigh,
                    color: _iconBool ? Colors.amber : Colors.brown,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'PRÉVISIONS - 5 PROCHAINS JOURS',
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
            color: _iconBool ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<ForecastModel?>(
          future: _weatherAPI.getWeatherForecast(
              lat: _dataWeather.lat,
              lon: _dataWeather.lon),
          builder: (context, snapshot) {
            if (!snapshot.hasError &&
                snapshot.hasData &&
                _dataForecast != snapshot.data) {
              _dataForecast = snapshot.data!;
              return ForecastWidget();
            }
            else if (snapshot.hasError) {
              return MissingForecastsWidget(100);
            }
            else {
              return LoadingWidget(100);
            }
          },
        ),
      ],
    );
  }

  // TextWidget créé dans le cas d'un échec de la requête liée aux forecasts
  Widget MissingForecastsWidget(double height) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: height,
      child: Center(
        child: Text(
          'Une erreur est survenue lors de la recherche des prévisions météo...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _iconBool ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }


  // Widget présentant les prévisions météo sur les 5 jours qui suivent
  // la date courante pour une ville donnée
  Widget ForecastWidget() {

    // Filtrage des données de forecast récupérées à partir de notre API

    List<String> filteredDT = []; // Liste des noms de jour pour chaque prévision
    List<String> filteredIcon = []; // Liste des weather icon pour chaque prévision
    List<num> filteredTempMin = []; // Liste des températures minimales pour chaque prévision
    List<num> filteredTempMax = []; // Liste des températures maximales pour chaque prévision
    List<num> filteredHumidity = []; // Liste des valeurs d'humidité pour chaque prévision
    List<num> filteredWindSpeed = []; // Liste des vitesses du vent pour  chaque prévision

    //Toutes ces listes sont de taille égale au nombre de prévisions (5)

    for(int i = 0 ; i < _dataForecast.forecastList.length ; i++) {

      // Extraction des éléments constituant une date pour une prévision donnée
      String forecastDay = _dataForecast.forecastList[i].dt_txt.split("-")[2].split(" ")[0];
      String forecastMonth = _dataForecast.forecastList[i].dt_txt.split("-")[1];
      String forecastYear = _dataForecast.forecastList[i].dt_txt.split("-")[0];
      String forecastHour = _dataForecast.forecastList[i].dt_txt.split("-")[2].split(" ")[1].split(
          ":")[0];

      String currentDay = _dataForecast.forecastList[0].dt_txt.split(
          "-")[2].split(" ")[0];
      String currentMonth = _dataForecast.forecastList[0].dt_txt.split(
          "-")[1];
      String currentYear = _dataForecast.forecastList[0].dt_txt.split(
          "-")[0];


      if (currentDay.compareTo(forecastDay) < 0 &&
          forecastHour.contains("12") ||
          currentDay.compareTo(forecastDay) > 0 &&
              currentYear.compareTo(forecastYear) < 0 &&
              forecastHour.contains("12") ||
          currentDay.compareTo(forecastDay) > 0 &&
              currentYear.compareTo(forecastYear) == 0 &&
              currentMonth.compareTo(forecastMonth) < 0 &&
              forecastHour.contains("12")) {

        String forecastNameOfDay = DateFormat('EEEE','FR').format(DateTime.parse(_dataForecast.forecastList[i].dt_txt.toString()));
        forecastNameOfDay = forecastNameOfDay[0].toUpperCase() +
            forecastNameOfDay.substring(1);

        filteredDT.add(forecastNameOfDay);
        filteredIcon.add(_dataForecast.forecastList[i].weather.first.main);
        filteredTempMin.add(_dataForecast.forecastList[i].main.tempMin);
        filteredTempMax.add(_dataForecast.forecastList[i].main.tempMax);
        filteredHumidity.add(_dataForecast.forecastList[i].main.humidity);
        filteredWindSpeed.add(_dataForecast.forecastList[i].wind.speed);

      }
    }
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {

          return Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _iconBool ? Color(0xff696969) : Color(0xffA47CBF),
                    _iconBool ? Color(0xff7D7D7D) : Color(0xffDDCFE6),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    filteredDT[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _iconBool ? Colors.white : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.all(3.0),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: _iconBool ? Color(0xff696969) : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            width: 50,
                            child: getWeatherIcon(
                                weather: filteredIcon[index],
                                color: _iconBool ? Color(0xff68fcdc) : Colors
                                    .pink,
                                size: 35),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: ' ${Utils.toCelsius(
                                          filteredTempMin[index])}°C ',
                                      style: TextStyle(
                                        color: _iconBool ? Colors.white : Colors
                                            .black,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const WidgetSpan(
                                      child:
                                      Icon(Icons.arrow_circle_down,
                                          color: Colors.red, size: 15),
                                    ),

                                  ],
                                )),

                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ' ${Utils.toCelsius(
                                        filteredTempMax[index])}°C ',
                                    style: TextStyle(
                                      color: _iconBool ? Colors.white : Colors
                                          .black,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: Icon(Icons.arrow_circle_up_outlined,
                                        color: Colors.green, size: 15),
                                  ),
                                ],
                              ),
                            ),

                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '  Hum : ${(filteredHumidity[index])} %',
                                    style: TextStyle(
                                      color: _iconBool ? Colors.white : Colors
                                          .black,
                                      fontSize: 12,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Win : ${Utils.toKmh(
                                        filteredWindSpeed[index])} km/h',
                                    style: TextStyle(
                                      color: _iconBool ? Colors.white : Colors
                                          .black,
                                      fontSize: 12,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}