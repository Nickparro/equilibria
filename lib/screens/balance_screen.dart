import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Balance Personal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gráfico de Balance (simulado)'),
            SizedBox(height: 20),
            Icon(Icons.donut_large, size: 100), // Simula un gráfico por ahora
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // En versiones futuras: ir a sugerencias
              },
              child: Text('Ver Sugerencias'),
            ),
          ],
        ),
      ),
    );
  }
}
