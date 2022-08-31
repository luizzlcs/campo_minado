import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/model/tabuleiro.dart';
import 'package:flutter/material.dart';
import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/model/campo.dart';
import 'package:flutter/rendering.dart';
import '../model/explosao_exception.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({Key? key}) : super(key: key);

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

  void _onAbrir(Campo campo) {
    setState(() {
      if (_venceu != null) {
        return;
      }
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

  void _alterMarcacao(Campo campo) {
    setState(() {
      if (_venceu != null) {
        return;
      }
      campo.alternarMarcacao();
      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 8;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: qtdLinhas,
        colunas: qtdeColunas,
        qtdeBombas: 30,
      );
    }
    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onAbrir: _onAbrir,
                onAlterMarcacao: _alterMarcacao,
              );
            },
          ),
        ),
      ),
    );
  }
}
