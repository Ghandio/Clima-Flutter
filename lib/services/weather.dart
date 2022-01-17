import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/networking.dart';
class WeatherModel {
  Location location =  Location();

  Future<dynamic> getCityWeather(String cityName)async{
    NetworkHelper networkHelper=NetworkHelper(
        cityName: cityName
    );
   var weatherdata=await networkHelper.getDataByCityName();
   return weatherdata;


  }
    Future<dynamic> getLocationWeather()async{

    await location.getCurrentLocation();
    NetworkHelper networkHelper=NetworkHelper(
        latitude: location.latitude.toString(),
        longitude: location.longitude.toString());
    var weatherData=await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
