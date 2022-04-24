import 'package:flutter/material.dart';
import 'package:muslim_gap_app/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MuslimGap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
