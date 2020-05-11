import 'package:carfuel/login.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class splash extends StatefulWidget {
    @override
    _splashState createState() => _splashState();
  }
  
class _splashState extends State<splash> {
    @override
    Widget build(BuildContext context) {
      return Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 3,
            backgroundColor: Colors.grey,
            navigateAfterSeconds: loginpage(),
            loaderColor: Colors.red,
          ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/carfuelSplash.png'),
              fit: BoxFit.none
            )
          ),
      )
      ]
      );
    }
  }
