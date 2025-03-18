import 'package:flutter/material.dart';

class InfiniteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Бесконечный список'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Элемент $index'),
            onTap: () {
              // Показываем уведомление с выбранным элементом
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Вы выбрали: Элемент $index')),
              );
            },
          );
        },
      ),
    );
  }
}