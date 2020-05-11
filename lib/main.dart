import 'package:carfuel/login.dart';
import 'package:carfuel/splash.dart';
import 'package:flutter/material.dart';

void main()=>runApp(carfuel());

class carfuel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CarFuel',
        theme: ThemeData(
            primarySwatch: Colors.grey
        ),
        home: splash(),
      routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => loginpage(),
      },
    );
  }
}
