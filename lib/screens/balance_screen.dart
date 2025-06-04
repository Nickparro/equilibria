import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class BalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tiempoPorCategoria =
        Provider.of<MyAppState>(context).obtenerDistribucionTiempo();
    final totalTiempo = tiempoPorCategoria.values.fold(0.0, (a, b) => a + b);
    final categorias = tiempoPorCategoria.keys.toList();

     return Scaffold(
      appBar: AppBar(title: Text('Balance Personal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Distribución del Tiempo', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: List.generate(tiempoPorCategoria.length, (index) {
                    final categoria = categorias[index];
                    final valor = tiempoPorCategoria[categoria]!;
                    final porcentaje = totalTiempo == 0 ? 0 : (valor / totalTiempo) * 100;

                    return PieChartSectionData(
                      value: valor,
                      title: '${porcentaje.toStringAsFixed(1)}%',
                      color: _getColor(index),
                      radius: 100,
                      titleStyle: TextStyle(fontSize: 14, color: Colors.white),
                    );
                  }),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 12,
              children: categorias
                  .asMap()
                  .entries
                  .map((entry) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 12, height: 12, color: _getColor(entry.key)),
                          SizedBox(width: 5),
                          Text('${entry.value}: ${tiempoPorCategoria[entry.value]!.toInt()} min'),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(int index) {
    const colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];
    return colors[index % colors.length];
  }
}
