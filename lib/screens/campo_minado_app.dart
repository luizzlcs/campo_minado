import 'package:campo_minado/components/controller_count.dart';
import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro.widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({super.key});

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

    void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro!.reiniciar();
    });
  }

  void get reiniciar => _reiniciar();

  void _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro!.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    debugPrint(
        'CONTADOR DE BOMBAS NO TABULEIRO: ${context.watch<ControllerCount>().count}');
    final bombas = context.watch<ControllerCount>().count;
    debugPrint('CONTADOR DE BOMBAS variável BOMBA: $bombas');
    if (_tabuleiro == null) {
      int qtdColunas = 15;
      double tamanhoDoCampo = largura / qtdColunas;
      int qtdLinhas = (altura / tamanhoDoCampo).floor();

      _tabuleiro = Tabuleiro(
          linhas: qtdLinhas,
          colunas: qtdColunas,
          qtdBombas: bombas //context.read<ControllerCounter>().count,
          );
    }

    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    final contar = context.read<ControllerCount>().count;
    print('CONTADOR DE BOMBAS: $contar');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return TabuleiroWidget(
              tabuleiro: _getTabuleiro(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
              onAbrir: _abrir,
              onAlterMarcacao: _alternarMarcacao,
            );
          },
        ),
      ),
    );
  }
}
