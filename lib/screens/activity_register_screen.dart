import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ActivityRegisterScreen extends StatefulWidget {
  final String? categoria;
  final String? descripcion;
  final int? minutos;
  final int? index;
  final bool editar;

  ActivityRegisterScreen({
    this.categoria,
    this.descripcion,
    this.minutos,
    this.index,
    this.editar = false,
  });

  @override
  ActivityRegisterScreenState createState() => ActivityRegisterScreenState();
}

class ActivityRegisterScreenState extends State<ActivityRegisterScreen> {
  String? _selectedCategory;
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedHours = 0;
  int _selectedMinutes = 0;

  final List<String> _categories = [
    'Estudio',
    'Trabajo',
    'Ejercicio',
    'Descanso',
    'Ocio'
  ];

  List<int> _minuteOptions = List.generate(60, (i) => i);
  List<int> _hourOptions = List.generate(24, (i) => i);

  @override
  void initState() {
    super.initState();
    if (widget.editar) {
      _selectedCategory = widget.categoria;
      _descriptionController.text = widget.descripcion ?? '';
      _selectedHours = (widget.minutos ?? 0) ~/ 60;
      _selectedMinutes = (widget.minutos ?? 0) % 60;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _guardarActividad(BuildContext context) {
    final descripcion = _descriptionController.text.trim();
    final totalMinutes = (_selectedHours * 60) + _selectedMinutes;

    if (_selectedCategory == null || descripcion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor selecciona una categoría y escribe una descripción.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (totalMinutes == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La duración no puede ser cero.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final appState = Provider.of<MyAppState>(context, listen: false);

    if (widget.editar && widget.index != null) {
      appState.editarActividad(
        widget.index!,
        _selectedCategory!,
        totalMinutes,
        descripcion,
      );
    } else {
      appState.agregarActividad(
        _selectedCategory!,
        totalMinutes,
        descripcion,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F0FA),
      appBar: AppBar(
        title: Text(widget.editar ? 'Editar Actividad' : 'Registrar Actividad'),
        backgroundColor: Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text('Selecciona una categoría'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                onChanged: (value) => setState(() => _selectedCategory = value),
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción de la actividad',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Duración:", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _selectedHours,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                      onChanged: (value) => setState(() => _selectedHours = value!),
                      items: _hourOptions
                          .map((h) => DropdownMenuItem(value: h, child: Text('$h h')))
                          .toList(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _selectedMinutes,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                      onChanged: (value) => setState(() => _selectedMinutes = value!),
                      items: _minuteOptions
                          .map((m) => DropdownMenuItem(value: m, child: Text('$m min')))
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _guardarActividad(context),
                child: Text(
                  widget.editar ? 'Actualizar' : 'Guardar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
