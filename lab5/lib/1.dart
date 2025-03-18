import 'package:flutter/material.dart';
import '3.dart'; // Импортируем экраны
import '4.dart';
import '2.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Главный экран',
          style: TextStyle(color: Colors.white), // Белый цвет текста
        ),
        backgroundColor: Colors.blue, // Синий цвет фона AppBar
      ),
      body: Container(
        color: Colors.black12, // Салатовый цвет фона body
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Простой список',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Переход на экран с простым списком
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SimpleListScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Бесконечный список',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Переход на экран с бесконечным списком
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfiniteListScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Математический список',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Переход на экран с математическим списком
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MathListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
