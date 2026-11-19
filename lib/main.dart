import 'package:flutter/material.dart';

import 'screens/registro_screen.dart';

void main() {
  runApp(const HorasDeEstudoApp());
}

class HorasDeEstudoApp extends StatelessWidget {
  const HorasDeEstudoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horas de Estudo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const RegistroScreen(),
    );
  }
}
