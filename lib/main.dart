import 'package:flutter/material.dart';
import 'package:flutter_loginui/screen/auth/AuthScreen.dart';

void main () =>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Login',
      home: AuthScreen(),
    );
  }

}