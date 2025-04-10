import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModel? _weatherModel;
  final WeatherService = WeatherServices('04fadd10a5c14b5270697368bde365bf');

  _fetchWeather() async {
    //get city
    String city = await WeatherService.getCurrentCity();

    try {
      final weatherModel = await WeatherService.getWeather(city);
      setState(() {
        _weatherModel = weatherModel;
      });
    } catch (e) {}
  }

  String getAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/images/Clear.json';
    return 'assets/images/$mainCondition.json';
  }


  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(_weatherModel?.location ?? "loading city.." , style: TextStyle(fontSize: 20.0),),

            Lottie.asset(getAnimation(_weatherModel?.mainCondition)),
        Text("${_weatherModel?.temparature}°C"),
        ]
        ),
      ),
    );
  }
}
