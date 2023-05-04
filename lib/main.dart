import 'dart:js';

import 'package:flutter/material.dart';
import 'package:lec_1_1/Views/Screens/add_contact_page.dart';

import 'Views/Screens/HomePage.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: Colors.blueAccent,
        secondary: Colors.lightBlueAccent,
      ),
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.light,
        primary: Colors.blueAccent,
        secondary: Colors.lightBlueAccent,
      ),
    ),
    themeMode: ThemeMode.system,
    routes: {
      '/' : (context) => HomePage(),
      'add_contact_page' : (context) => add_contact_page(),
    },
  ),);
}