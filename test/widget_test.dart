import 'package:flutter_test/flutter_test.dart';
import 'package:horas_de_estudo/main.dart';

void main() {
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
