import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Widget responsable de l'affichage d'une icône liée à la température actuelle
// et aux températures de prévisions pour une ville donnée
Widget getWeatherIcon({required String weather,required Color color,required double size}) {

  switch(weather){
    case "Clear":
      {return Icon(FontAwesomeIcons.sun,color: color,size:size);}
      break;

    case "Clouds":
      {return Icon(FontAwesomeIcons.cloud,color: color,size:size);}
      break;

    case "Rain":
      {return Icon(FontAwesomeIcons.cloudRain,color: color,size:size);}
      break;

    case "Snow":
      {return Icon(FontAwesomeIcons.snowman,color: color,size:size);}
      break;

    default: {return Icon(FontAwesomeIcons.sun,color: color,size:size);}
  }
}