import 'package:flutter/material.dart';
import 'package:taskapp4/Screen/Home.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      );
  
  }
}