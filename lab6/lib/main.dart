import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(primarySwatch: Colors.red),
      home: AreaCalculator(),
    );
  }
}

class AreaCalculator extends StatefulWidget {
  @override
  _AreaCalculatorState createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  String _result = '';

  void _calculateArea() {
    if (_formKey.currentState!.validate()) {
      final width = double.parse(_widthController.text.replaceAll(',', '.'));
      final height = double.parse(_heightController.text.replaceAll(',', '.'));
      final area = width * height;

      setState(() {
        _result = 'S = $width × $height = ${area.toStringAsFixed(2)}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Площадь успешно вычислена!'),
          backgroundColor: Colors.blueAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор площади')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _widthController,
                decoration: const InputDecoration(
                  labelText: 'Ширина (мм)',
                  hintText: 'Введите число ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле обязательно для заполнения';
                  }
                  final parsedValue = double.tryParse(value.replaceAll(',', '.'));
                  if (parsedValue == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Высота (мм)',
                  hintText: 'Введите число',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле обязательно для заполнения';
                  }
                  final parsedValue = double.tryParse(value.replaceAll(',', '.'));
                  if (parsedValue == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _calculateArea,
                child: const Text('Вычислить'),
              ),
              const SizedBox(height: 30),
              Text(
                _result,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
