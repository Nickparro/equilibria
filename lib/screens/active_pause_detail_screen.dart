
import 'package:flutter/material.dart';
import 'dart:async';

class ActivePauseDetailScreen extends StatefulWidget {
  final String title;

  const ActivePauseDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  _ActivePauseDetailScreenState createState() => _ActivePauseDetailScreenState();
}

class _ActivePauseDetailScreenState extends State<ActivePauseDetailScreen> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Instrucciones:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Realiza esta pausa activa durante 1 minuto. Respira profundamente, relaja los hombros y enfócate en tu bienestar.",
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
              child: Text("Finalizar pausa"),
            )
          ],
        ),
      ),
    );
  }
}
