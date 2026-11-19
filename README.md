# Horas de Estudo

**Aluno:** Madson Ferreira de Souza
**Instituição:** IFF-INMETRO/XERÉM – Curso de Cibersegurança
**Disciplina:** Programação de Sistemas Embarcados
**Trabalho:** Trabalho Final – Desenvolvimento de Aplicativos com Flutter (navegação entre telas e utilização de bibliotecas externas)
**Professor:** Wladmir Chapetta Chapetta

**App no navegador (Chrome):** https://mmcconservador-svg.github.io/Trabalho-Final-da-Disciplina-de-Sistemas-Embarcados/

## 1. Descrição do aplicativo

O **Horas de Estudo** é um aplicativo Flutter simples para registrar quantas horas o usuário estudou em cada dia da semana, contar sessões de estudo e visualizar o resultado em um gráfico de barras.

## 2. Telas e funcionalidades

| Tela | Arquivo | Funcionalidades |
|------|---------|-----------------|
| **1 – Registro de Estudo** | `lib/screens/registro_screen.dart` | Lista os 7 dias da semana, cada um com um `Slider` (0 a 8 h, passos de 0,5 h); total semanal; botão flutuante **+** que conta sessões de estudo (`setState`); botão para zerar; botão **Ver gráfico**. |
| **2 – Gráfico Semanal** | `lib/screens/grafico_screen.dart` | Indicadores (total, média diária e sessões) e gráfico de barras com as horas de cada dia; botão **Voltar**. |

**Navegação:**
- Tela 1 → Tela 2: `Navigator.push()` com `MaterialPageRoute`, enviando os dados pelo construtor.
- Tela 2 → Tela 1: `Navigator.pop()` no botão **Voltar** (também pela seta da AppBar e pelo botão voltar do Android).

## 3. Biblioteca externa

- **Pacote:** `fl_chart`
- **Link no pub.dev:** https://pub.dev/packages/fl_chart
- **Justificativa:** biblioteca popular e bem mantida para gráficos, escrita 100% em Dart/Flutter (sem código nativo), portanto compatível com **Web e Android**. Entrega uma funcionalidade claramente perceptível: transformar os dados digitados em um gráfico visual.

### Como foi utilizada

1. Adicionada em `pubspec.yaml`: `fl_chart: ^0.69.2`.
2. Importada em `lib/screens/grafico_screen.dart` (`import 'package:fl_chart/fl_chart.dart';`).
3. O widget `BarChart` recebe um `BarChartData` com um `BarChartGroupData` por dia (altura = horas estudadas), títulos dos eixos personalizados (`FlTitlesData`) e eixo Y fixo de 0 a 8 horas.

## 4. Conceitos aproveitados do exemplo da aula

O exemplo do professor (contador com `StatefulWidget`) foi a base da estrutura do app:

| Conceito do exemplo | Onde aparece neste projeto |
|---|---|
| `runApp` + `MaterialApp` com `debugShowCheckedModeBanner: false` e `colorSchemeSeed` | `lib/main.dart` |
| `StatefulWidget` + `setState` | Tela 1: sliders de horas e contador de sessões |
| `Scaffold` + `AppBar` | As duas telas |
| `FloatingActionButton` com ícone `+` | Tela 1: incrementa as sessões de estudo |
| Diferença entre alterar a variável e chamar `setState` | O contador só atualiza na tela porque usa `setState` |

## 5. Como executar

### Opção A – Sem instalar nada (Chrome)

Abra o link: https://mmcconservador-svg.github.io/Trabalho-Final-da-Disciplina-de-Sistemas-Embarcados/

O site é gerado e publicado automaticamente pelo GitHub Actions (`.github/workflows/publicar.yml`) a cada `push` na `main`. O mesmo fluxo também gera o APK de Android, disponível em **Actions → última execução → Artifacts → horas-de-estudo-apk**.

### Opção B – Com o Flutter instalado

Pré-requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install), Google Chrome e, para Android, emulador ou dispositivo físico com depuração USB.

```bash
git clone https://github.com/mmcconservador-svg/Trabalho-Final-da-Disciplina-de-Sistemas-Embarcados.git
cd Trabalho-Final-da-Disciplina-de-Sistemas-Embarcados

# Gera as pastas android/ e web/ (mantém lib/ e pubspec.yaml)
flutter create --platforms=web,android --project-name horas_de_estudo .
flutter pub get
```

**Navegador (Web):**

```bash
flutter run -d chrome
# alternativa, se o Chrome não for encontrado:
flutter run -d web-server --web-port 8080     # e abra http://localhost:8080
```

**Android:**

```bash
flutter devices          # confira se o emulador/dispositivo aparece
flutter run -d <id-do-dispositivo>
```

**Testes:**

```bash
flutter test
```

## 6. Estrutura do projeto

```
lib/
  main.dart                      # ponto de entrada e tema
  screens/
    registro_screen.dart         # Tela 1
    grafico_screen.dart          # Tela 2 (usa fl_chart)
test/
  widget_test.dart               # testa setState e navegação ida e volta
.github/workflows/publicar.yml   # build, testes e publicação web + APK
pubspec.yaml
```

## 7. Evidências de execução

As evidências estão na pasta [`evidencias/`](evidencias/): execução no Chrome (Tela 1, Tela 2 com o gráfico `fl_chart`) e o build/publicação automáticos no GitHub Actions. O APK de Android é gerado no mesmo fluxo (Actions → Artifacts → `horas-de-estudo-apk`).
