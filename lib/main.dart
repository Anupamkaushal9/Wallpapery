import 'package:flutter/material.dart';
import 'package:wallpapery/wallpaper.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,theme: new ThemeData(brightness: Brightness.dark),
      home: Wallpaper()
      ,);
  }
}
