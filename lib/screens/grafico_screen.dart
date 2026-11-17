import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Tela 2: mostra as horas da Tela 1 em um grafico de barras (pacote fl_chart).
class GraficoScreen extends StatelessWidget {
  const GraficoScreen({super.key, required this.dias, required this.horas});

  final List<String> dias;
  final List<double> horas;

  @override
  Widget build(BuildContext context) {
    final cor = Theme.of(context).colorScheme;
    final total = horas.fold<double>(0, (soma, h) => soma + h);
    final media = horas.isEmpty ? 0.0 : total / horas.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico Semanal'),
        backgroundColor: cor.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _Indicador(
                    titulo: 'Total',
                    valor: '${total.toStringAsFixed(1)} h',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _Indicador(
                    titulo: 'Média diária',
                    valor: '${media.toStringAsFixed(1)} h',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  minY: 0,
                  maxY: 8,
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text('Horas'),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: 2,
                        getTitlesWidget: (valor, meta) =>
                            Text(valor.toInt().toString()),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (valor, meta) {
                          final i = valor.toInt();
                          if (i < 0 || i >= dias.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              dias[i].substring(0, 3),
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (var i = 0; i < horas.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: horas[i],
                            color: cor.primary,
                            width: 18,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                // Retorno da Tela 2 -> Tela 1 (Navigator.pop).
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Indicador extends StatelessWidget {
  const _Indicador({required this.titulo, required this.valor});

  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(titulo, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(valor, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
