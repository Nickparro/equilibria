import 'package:flutter/material.dart';
import 'active_pause_detail_screen.dart';

class ActivePausesSuggestionScreen extends StatelessWidget {
  final List<Map<String, String>> activePauses = [
    {
      'title': 'Respiración consciente',
      'description':
          'Para realizar una pausa activa de respiración, siéntate o párate cómodamente, relaja los hombros y el cuello, y cierra los ojos. Inhala por 4 segundos, sostén por 4 y exhala por 4. Repite durante 1 minuto para relajarte.',
      'image': 'assets/images/ImagenUno.png',
    },
    {
      'title': 'Estiramiento exprés',
      'description':
          'Para realizar una pausa activa de estiramiento express, sigue estos pasos: Inicia con movimientos suaves de cuello y hombros. Ponte de pie, estira brazos hacia arriba y luego hacia los lados.Finaliza con movimientos circulares de muñecas y tobillos. Libera tensión en cuello y hombros.',
      'image': 'assets/images/ImagenDos.png',
    },
    {
      'title': 'Meditación guiada',
      'description':
          'Para realizar una pausa activa con meditación guiada, sigue estos pasos: busca un lugar tranquilo, siéntate cómodamente,Cierra los ojos, escucha la meditación guiada, enfócate en la respiración y las sensaciones corporales. Respira con calma y concéntrate en el sonido de tu respiración o una música suave.',
      'image': 'assets/images/ImagenTres.png',
    },
    {
      'title': 'Caminata breve',
      'description':
          'Para realizar una pausa activa de caminata breve, primero, levántate de tu lugar de trabajo y comienza a caminar lentamente por un espacio designado. Camina lentamente por tu espacio durante 1 minuto. Observa tu entorno y respira con conciencia. Camina a un ritmo moderado, ni demasiado rápido ni demasiado lento, y realiza movimientos suaves con los brazos. Realiza movimientos circulares con los hombros y el cuello para liberar tensión. Al finalizar la caminata, puedes realizar ejercicios de estiramiento para brazos,',
      'image': 'assets/images/ImagenCuatro.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F0FA),
      appBar: AppBar(
        title: Text('Pausas Activas Sugeridas'),
        backgroundColor: Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: activePauses.length,
        itemBuilder: (context, index) {
          final pause = activePauses[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivePauseDetailScreen(
                            title: pause['title']!,
                            description: pause['description']!,
                            image: pause['image']!,
                          ),
                        ),
                      );
                    },
                    child: Text('Iniciar', style: TextStyle(color: Colors.white)), 
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
