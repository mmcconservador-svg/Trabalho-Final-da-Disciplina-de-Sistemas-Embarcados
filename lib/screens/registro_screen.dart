import 'package:flutter/material.dart';

import 'grafico_screen.dart';

/// Tela 1: o usuario registra quantas horas estudou em cada dia da semana.
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  static const List<String> dias = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo',
  ];

  final List<double> horas = [2, 3, 1.5, 4, 2.5, 1, 0];

  /// Contador de sessoes de estudo (conceito do exemplo da aula: setState).
  int sessoes = 0;

  void _incrementarSessoes() {
    // setState avisa o Flutter que o estado mudou e a tela deve ser redesenhada.
    setState(() {
      sessoes++;
    });
  }

  void _abrirGrafico() {
    // Navegacao da Tela 1 -> Tela 2 (Navigator.push).
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GraficoScreen(
          dias: dias,
          horas: List.of(horas),
          sessoes: sessoes,
        ),
      ),
    );
  }

  void _zerar() {
    setState(() {
      for (var i = 0; i < horas.length; i++) {
        horas[i] = 0;
      }
      sessoes = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = horas.fold<double>(0, (soma, h) => soma + h);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Estudo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            tooltip: 'Zerar horas',
            icon: const Icon(Icons.refresh),
            onPressed: _zerar,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementarSessoes,
        tooltip: 'Registrar uma sessão de estudo',
        icon: const Icon(Icons.add),
        label: Text('Sessões: $sessoes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Ajuste as horas estudadas em cada dia da semana e use o botão + '
              'para contar sessões de estudo.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: dias.length,
              itemBuilder: (context, i) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 76,
                          child: Text(
                            dias[i],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: horas[i],
                            min: 0,
                            max: 8,
                            divisions: 16,
                            label: '${horas[i].toStringAsFixed(1)} h',
                            onChanged: (valor) {
                              setState(() => horas[i] = valor);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 48,
                          child: Text(
                            '${horas[i].toStringAsFixed(1)} h',
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Na bottomNavigationBar o botao flutuante fica ACIMA dela, sem sobrepor.
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total da semana: ${total.toStringAsFixed(1)} h',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _abrirGrafico,
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('Ver gráfico'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
