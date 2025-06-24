import 'package:flutter/material.dart';
import 'dart:async';

class ActivePauseDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String image;

  const ActivePauseDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  ActivePauseDetailScreenState createState() => ActivePauseDetailScreenState();
}

class ActivePauseDetailScreenState extends State<ActivePauseDetailScreen> {
  int _seconds = 60;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text('🎉 ¡Pausa completada!', textAlign: TextAlign.center),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Respira profundo y sigue con tu día 😊',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/emoji_equilibria.png',
                    height: 100,
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cierra el diálogo
                      Navigator.pop(context); // Vuelve a la pantalla anterior
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6C63FF),
                    ),
                    child: Text('Aceptar'),
                  ),
                )
              ],
            );
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.image,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                "⏱️ $_seconds s",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6C63FF),
              ),
              child: Text("Finalizar pausa", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
