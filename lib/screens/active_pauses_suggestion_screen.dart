
import 'package:flutter/material.dart';

class ActivePausesSuggestionScreen extends StatelessWidget {
  final List<Map<String, String>> activePauses = [
    {
      'title': 'Respiración consciente',
      'image': 'assets/images/breathing.png',
    },
    {
      'title': 'Estiramiento exprés',
      'image': 'assets/images/stretch.png',
    },
    {
      'title': 'Meditación guiada',
      'image': 'assets/images/meditation.png',
    },
    {
      'title': 'Caminata breve',
      'image': 'assets/images/walk.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pausas Activas Sugeridas'),
      ),
      body: ListView.builder(
        itemCount: activePauses.length,
        itemBuilder: (context, index) {
          final pause = activePauses[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      pause['image']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      pause['title']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí más adelante se iniciará la pausa
                    },
                    child: Text('Iniciar'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
