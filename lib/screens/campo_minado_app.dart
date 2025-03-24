import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro.widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  final BoxConstraints constraints;
  final int bombas;
  late final Tabuleiro _tabuleiro;

  CampoMinadoApp({required this.constraints, required this.bombas}) {
    int qtdColunas = 15;
    double tamanhoDoCampo = this.constraints.maxWidth / qtdColunas;
    int qtdLinhas = (this.constraints.maxHeight / tamanhoDoCampo).floor();

    this._tabuleiro =
        Tabuleiro(linhas: qtdLinhas, colunas: qtdColunas, qtdBombas: bombas);
  }

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;

  _CampoMinadoAppState();

  void _reiniciar() {
    setState(() {
      _venceu = null;
      widget._tabuleiro.reiniciar();
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
        if (widget._tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        widget._tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alternarMarcacao();
      if (widget._tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campo minado',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: TabuleiroWidget(
          tabuleiro: widget._tabuleiro,
          onAbrir: _abrir,
          onAlterMarcacao: _alternarMarcacao,
        ),
      ),
    );
  }
}
