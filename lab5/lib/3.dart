import 'package:flutter/material.dart';

class SimpleListScreen extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Строка $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Простой список'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              // Показываем уведомление с выбранным элементом
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Вы выбрали: ${items[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}