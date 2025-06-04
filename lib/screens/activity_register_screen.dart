import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ActivityRegisterScreen extends StatefulWidget {
  @override
  _ActivityRegisterScreenState createState() => _ActivityRegisterScreenState();
}

class _ActivityRegisterScreenState extends State<ActivityRegisterScreen> {
  String? _selectedCategory;
  int _duration = 30;

  final List<String> _categories = [
    'Estudio',
    'Trabajo',
    'Ejercicio',
    'Descanso',
    'Ocio'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Actividad')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: Text('Selecciona una categoría'),
              onChanged: (value) {
                setState(() => _selectedCategory = value);
              },
              items: _categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Duración (minutos):'),
            Slider(
              value: _duration.toDouble(),
              min: 10,
              max: 180,
              divisions: 17,
              label: '$_duration',
              onChanged: (value) {
                setState(() => _duration = value.toInt());
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 if (_selectedCategory != null) {
                  Provider.of<MyAppState>(context, listen: false)
                      .agregarActividad(_selectedCategory!, _duration);
                }
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
