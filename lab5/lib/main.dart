import 'package:flutter/material.dart';
import '1.dart'; // Импортируем главный экран

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа 5 и 7',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), // Указываем главный экран
    );
  }
}