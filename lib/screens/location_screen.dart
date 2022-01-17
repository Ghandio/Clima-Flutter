import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.data});

  final String data;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  double temp;
  String weatherIcon;
  String cityName;
  String message;

  @override
  void initState() {
    updateUI(widget.data);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if(widget.data==null){
        temp=0;
        message="Unable to get weather data";
        weatherIcon="there's no icon";
        cityName='';
        return;

      }
      temp=jsonDecode(widget.data)['main']['temp'];
      message=weather.getMessage(temp.toInt());
      weatherIcon= weather.getWeatherIcon(jsonDecode(widget.data)['weather'][0]['id']);
      cityName = jsonDecode(widget.data)['name'];
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData= await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName=await Navigator.push(context,
                          MaterialPageRoute(builder:(context) {
                            return CityScreen();
                          }));
                     if(typedName!=null){
                      var weatherdata= await weather.getCityWeather(typedName);
                      setState(() {
                        updateUI(weatherdata);
                      });
                     }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName ",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
