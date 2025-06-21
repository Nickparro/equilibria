import 'package:equilibria/screens/activity_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historial = Provider.of<MyAppState>(context).obtenerHistorial();

    return Scaffold(
      backgroundColor: Color(0xFFE6F0FA),
      appBar: AppBar(
        title: Text('Historial de Actividades'),
        backgroundColor: Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: historial.isEmpty
            ? Center(
                child: Text(
                  'No hay actividades registradas.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
            : ListView.builder(
                itemCount: historial.length,
                itemBuilder: (context, index) {
                  final actividad = historial[index];
                  final horas = actividad.minutos ~/ 60;
                  final minutos = actividad.minutos % 60;

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: _getColor(actividad.categoria),
                          child: Text(
                            actividad.categoria.substring(0, 1),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                actividad.categoria,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                actividad.descripcion,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text('${horas}h ${minutos}m',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87)),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.grey.shade600),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ActivityRegisterScreen(
                                      categoria: actividad.categoria,
                                      descripcion: actividad.descripcion,
                                      minutos: actividad.minutos,
                                      index: index,
                                      editar: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Color _getColor(String categoria) {
    switch (categoria) {
      case 'Estudio':
        return Colors.blue;
      case 'Trabajo':
        return Colors.green;
      case 'Ejercicio':
        return Colors.orange;
      case 'Descanso':
        return Colors.purple;
      case 'Ocio':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
