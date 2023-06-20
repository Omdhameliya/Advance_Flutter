import 'dart:async';
import 'package:flutter/material.dart';

class splashscrren extends StatefulWidget {
  const splashscrren({Key? key}) : super(key: key);

  @override
  State<splashscrren> createState() => _splashscrrenState();
}

class _splashscrrenState extends State<splashscrren> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("homepage");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/1.jpg",
            ),
            scale: 2,
          ),
        ),
        // child: Image.asset("assets/m.png"),
      );
  }
}
