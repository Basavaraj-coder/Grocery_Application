import 'package:bloc_mastering/Features/HomeScreen/UI/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.amberAccent),
      home: Scaffold(
        body: HomeScreen(),
          ),
    );
  }
}