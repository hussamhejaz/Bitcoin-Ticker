import 'package:flutter/material.dart';
import 'pricescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.lightBlue,
            scaffoldBackgroundColor: Colors.white),
        home:const  PricePage()
    );
    }

}
