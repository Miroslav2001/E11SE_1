
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:first_prototype/Home.dart';
import 'package:first_prototype/Example.dart';
import 'package:first_prototype/Fire_Index.dart';


void main() => runApp(MaterialApp(

  initialRoute: '/home',
  routes: {
    '/home':(context) => Home(),
    '/example': (context) => Forecast(),
    '/fire_index': (context) => FireIndex(),

},


));

