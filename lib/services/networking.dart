import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
const apiKey='c466bf6c0689fb66afc7bc97ab9e6a54';
class NetworkHelper {
  NetworkHelper({ this.latitude, this.longitude,this.cityName});
  final String latitude;
  final String longitude;
  final String cityName;

  Future getData() async {
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'lat':latitude, 'lon': longitude, 'appid': apiKey, 'units':'metric'});
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }
  Future getDataByCityName() async {
    Uri uri=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=c466bf6c0689fb66afc7bc97ab9e6a54');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
