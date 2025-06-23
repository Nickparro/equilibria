import 'package:flutter/material.dart';

class ActivePausesSuggestionScreen extends StatelessWidget {
  final List<Map<String, String>> activePauses = [
    {
      'title': 'Respiración consciente',
      'image': 'assets/images/ImagenUno.png',
    },
    {
      'title': 'Estiramiento exprés',
      'image': 'assets/images/ImagenDos.png',
    },
    {
      'title': 'Meditación guiada',
      'image': 'assets/images/ImagenTres.png',
    },
    {
      'title': 'Caminata breve',
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
                      title: pause['title']!
                               },
                    child: Text(
                      'Iniciar',
                      style: TextStyle(color: Colors.white),
                    ),
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
