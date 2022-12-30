class Utils {

  static const String API_KEY = "c0d372cd7a944e85f0118878af7c913f";
  static const String API_URL = "https://api.openweathermap.org/data/2.5";

  // Fonction de conversion de température (Kelvin -> Celsius)
  static int toCelsius(num temperature) {
    return (temperature - 274).round();
  }

  // Fonction de conversion pour la vitesse du vent (mph -> km/h)
  static int toKmh(num speed) {
    return (speed * 1.609344).round();
  }


}
