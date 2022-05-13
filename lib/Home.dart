import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:first_prototype/Example.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:first_prototype/example_weather.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

    @override
    State<Home> createState() => _HomeState();
  }

  @override
  State<Home> createState() => _HomeState();
  final _controller = TextEditingController();
  var input = _controller.text.split(" ");
  var lat = input[0];
  var lon = input[1];




class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [],
          ),
          SizedBox(height: 30.0,),
          Text(
            "My Ranger's Tool",
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            "Providing the weather data you need!",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _controller,
                cursorColor: Theme.of(context).cursorColor,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Latitude and Longitude',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),
                  helperText: 'separate them with a space',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/fire_index');
                },
                child: Text("      Search       ")
            ),
          )

        ],
      ),
    );}}



