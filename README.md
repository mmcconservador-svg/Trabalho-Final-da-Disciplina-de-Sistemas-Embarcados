# Horas de Estudo

**Aluno:** Madson Ferreira de Souza
**Disciplina:** Desenvolvimento de Aplicativos
**Trabalho:** Trabalho Final – Navegação entre telas e utilização de bibliotecas externas (Flutter)

## 1. Descrição do aplicativo

O **Horas de Estudo** é um aplicativo Flutter simples para registrar quantas horas o usuário estudou em cada dia da semana e visualizar o resultado em um gráfico de barras.

## 2. Telas e funcionalidades

| Tela | Arquivo | Funcionalidades |
|------|---------|-----------------|
| **1 – Registro de Estudo** | `lib/screens/registro_screen.dart` | Lista os 7 dias da semana, cada um com um `Slider` (0 a 8 h, passos de 0,5 h); mostra o total semanal; botão para zerar as horas; botão **Ver gráfico**. |
| **2 – Gráfico Semanal** | `lib/screens/grafico_screen.dart` | Exibe indicadores (total e média diária) e o gráfico de barras com as horas de cada dia; botão **Voltar**. |

**Navegação:**
- Tela 1 → Tela 2: `Navigator.push()` com `MaterialPageRoute`, enviando os dados pelo construtor.
- Tela 2 → Tela 1: `Navigator.pop()` no botão **Voltar** (também funciona pela seta da AppBar e pelo botão voltar do Android).

## 3. Biblioteca externa

- **Pacote:** `fl_chart`
- **Link no pub.dev:** https://pub.dev/packages/fl_chart
- **Justificativa:** biblioteca popular e bem mantida para gráficos, escrita 100% em Dart/Flutter (sem código nativo), portanto compatível com **Web e Android**. Entrega uma funcionalidade claramente perceptível: transformar os dados digitados em um gráfico visual.

### Como foi utilizada

1. Adicionada em `pubspec.yaml`: `fl_chart: ^0.69.2`.
2. Importada em `lib/screens/grafico_screen.dart` (`import 'package:fl_chart/fl_chart.dart';`).
3. O widget `BarChart` recebe um `BarChartData` com um `BarChartGroupData` por dia (altura = horas estudadas), títulos dos eixos personalizados (`FlTitlesData`) e eixo Y fixo de 0 a 8 horas.

## 4. Como executar

Pré-requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (`flutter doctor` sem erros), Google Chrome e, para Android, um emulador ou dispositivo físico com depuração USB.

```bash
git clone https://github.com/mmcconservador-svg/Trabalho-Final-da-Disciplina-de-Sistemas-Embarcados.git
cd Trabalho-Final-da-Disciplina-de-Sistemas-Embarcados

# Gera as pastas android/ e web/ (mantém lib/ e pubspec.yaml)
flutter create --platforms=web,android --project-name horas_de_estudo .

flutter pub get
```

### No navegador (Web)

```bash
flutter run -d chrome
```

### No Android

```bash
flutter devices          # confira se o emulador/dispositivo aparece
flutter run -d <id-do-dispositivo>
```

### Testes

```bash
flutter test
```

## 5. Estrutura do projeto

```
lib/
  main.dart                      # ponto de entrada e tema
  screens/
    registro_screen.dart         # Tela 1
    grafico_screen.dart          # Tela 2 (usa fl_chart)
test/
  widget_test.dart               # testa navegação ida e volta
pubspec.yaml
```

## 6. Evidências de execução

As capturas de tela / vídeo da execução no Chrome e no Android estão na pasta [`evidencias/`](evidencias/).
