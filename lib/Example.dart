import 'dart:convert';
import 'dart:io';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:first_prototype/example_weather.dart';
import 'package:first_prototype/Home.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Forecast extends StatefulWidget {
  const Forecast({Key? key}) : super(key: key);

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  final _controller = TextEditingController();
  Location location = Location();
  bool searching = false;

  dynamic uploadLocation() async {
    dynamic res = [lat, lon];
    return res;
  }
  Widget personalWeather() {
    return FutureBuilder<dynamic>(
      future: uploadLocation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var lat1 = snapshot.data[0];
          var lon2 = snapshot.data[1];
          return FutureBuilder<Weather>(
              future: getCurrentWeather(lat1, lon2),
              builder: (context, s) {
                if (s.hasData) {
                  var w = s.data;
                  return weatherBox(w!);
                } else {
                  return const CircularProgressIndicator();
                }
              });
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }


  Widget searchedWeather(lat, lon) {
    return FutureBuilder<Weather>(
        future: getCurrentWeather(lat, lon),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _w = snapshot.data;
            return weatherBox(_w!);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
  Widget transformer() {
    if (!searching) {
      return personalWeather();
    } else {
      var input = _controller.text.split(" ");
      var lat1 = input[0];
      var lon2 = input[1];
      return searchedWeather(lat1, lon2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Forecast"),
          backgroundColor: const Color(0xFF6200EE),
        ),
        body: Column(
          children: [
            FutureBuilder<dynamic>(
                future: uploadLocation(),
                builder: (context, pos) {
                  if (pos.hasData) {
                    var lat = pos.data[0];
                    var lon = pos.data[1];
                    return Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Lat: ${lat}"), Text("Lon: ${lon}")]),
                    );
                  } else {
                    return Container();
                  }
                }),
            Center(child: transformer())
          ],
        ),
      ),
    );
  }
}

Widget weatherBox(Weather _weather) {
  return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    Container(
        margin: const EdgeInsets.all(10.0),
        child: Text(
          "${_weather.temp}°C",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
        )),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.all(10.0),
            child: Icon(translateIcon(_weather.weatherCode))),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < 9; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Icon(translateIcon(_weather.hourlyCode[i]))),
                    Container(
                        child: Text("${_weather.hourlyTime[i].substring(11)}")),
                    Container(child: Text("${_weather.hourlyTemp[i]}°C")),
                  ],
                )
            ],
          ),
        )
      ],
    ),
  ]);
}
Future<Weather> getCurrentWeather(lat, lon) async {
  Weather _w;
  print(lat);

  final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=temperature_2m,weathercode");
  final res = await http.get(url);
  if (res.statusCode == 200) {
    print("SUCCESS");
    _w = Weather.fromJson(jsonDecode(res.body));
  } else {
    print("ERROR");
    throw Exception("failed");
  }
  return _w;
}

IconData translateIcon(int n) {
  dynamic dic = {
    0: Icons.wb_sunny,
    1: Icons.cloud,
    2: Icons.cloud,
    3: Icons.cloud,
  };
  return dic[n];
}


//https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m,weathercode
