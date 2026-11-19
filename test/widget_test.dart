import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_de_estudo/main.dart';

void main() {
  testWidgets('botão + incrementa o contador de sessões (setState)',
      (tester) async {
    await tester.pumpWidget(const HorasDeEstudoApp());

    expect(find.text('Sessões: 0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Sessões: 1'), findsOneWidget);
  });

  testWidgets('navega da Tela 1 para a Tela 2 e volta', (tester) async {
    await tester.pumpWidget(const HorasDeEstudoApp());

    expect(find.text('Registro de Estudo'), findsOneWidget);

    await tester.tap(find.text('Ver gráfico'));
    await tester.pumpAndSettle();
    expect(find.text('Gráfico Semanal'), findsOneWidget);

    await tester.tap(find.text('Voltar'));
    await tester.pumpAndSettle();
    expect(find.text('Registro de Estudo'), findsOneWidget);
  });
}
