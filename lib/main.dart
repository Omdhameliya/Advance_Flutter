import 'package:flutter/material.dart';
import 'views/homepage.dart';
import 'views/splashscreen.dart';

void main() {
  runApp(
      Mymusic(),
  );
}

class Mymusic extends StatefulWidget {
  const Mymusic({Key? key}) : super(key: key);

  @override
  State<Mymusic> createState() => _MymusicState();
}

class _MymusicState extends State<Mymusic> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'homepage':(context)=>homepage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Builder(
        builder: (context) => splashscrren(),
      ),
    );
  }
}

