import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class BalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tiempoPorCategoria =
        Provider.of<MyAppState>(context).obtenerDistribucionTiempo();
    final totalTiempo =
        tiempoPorCategoria.values.fold(0.0, (a, b) => a + b);
    final categorias = tiempoPorCategoria.keys.toList();

    final porcentajes = tiempoPorCategoria.map((cat, tiempo) {
      final porcentaje =
          totalTiempo == 0 ? 0.0 : (tiempo / totalTiempo) * 100;
      return MapEntry(cat, porcentaje);
    });

    final mensajeBalance = _evaluarBalance(porcentajes);

    return Scaffold(
      backgroundColor: Color(0xFFE6F0FA),
      appBar: AppBar(
        title: Text('Balance Personal'),
        backgroundColor: Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 6),
              )
            ],
          ),
          child: Column(
            children: [
              Text(
                'Distribución del Tiempo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A4A88),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 240,
                child: PieChart(
                  PieChartData(
                    sections: List.generate(
                      tiempoPorCategoria.length,
                      (index) {
                        final categoria = categorias[index];
                        final valor = tiempoPorCategoria[categoria]!;
                        final porcentaje =
                            totalTiempo == 0 ? 0 : (valor / totalTiempo) * 100;

                        return PieChartSectionData(
                          value: valor,
                          title: '${porcentaje.toStringAsFixed(1)}%',
                          color: _getColor(index),
                          radius: 90,
                          titleStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: categorias
                    .asMap()
                    .entries
                    .map(
                      (entry) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getColor(entry.key),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            '${entry.value}: ${tiempoPorCategoria[entry.value]!.toInt()} min',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 24),
              Text(
                mensajeBalance,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6C63FF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor(int index) {
    const colors = [
      Color(0xFF4A90E2),
      Color(0xFF50E3C2), 
      Color(0xFFFFC542),
      Color(0xFF9B51E0),
      Color(0xFFFF6B6B), 
    ];
    return colors[index % colors.length];
  }

  String _evaluarBalance(Map<String, double> porcentajes) {
    if (porcentajes.values.every((p) => p == 0)) {
      return "Aún no has registrado actividades.";
    }

    final promedio =
        porcentajes.values.reduce((a, b) => a + b) / porcentajes.length;
    final categoriaMenor =
        porcentajes.entries.reduce((a, b) => a.value < b.value ? a : b);

    if (categoriaMenor.value < promedio * 0.75) {
      return "Estás descuidando ${categoriaMenor.key.toLowerCase()}, ¡no lo olvides!";
    }

    return "¡Estás balanceado!";
  }
}
