import 'package:flutter/material.dart';
import 'dart:math'; // Импортируем библиотеку для математических операций

class MathListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Математический список'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final result = pow(2, index); // Вычисляем 2^index
          return ListTile(
            title: Text('2^$index = $result'),
            onTap: () {
              // Показываем уведомление с выбранным элементом
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Вы выбрали: 2^$index = $result')),
              );
            },
          );
        },
      ),
    );
  }
}