import 'dart:math';
import 'package:campo_minado/models/campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }
  
 
  
  void _criarCampos() {
    for(int l = 0; l < linhas; l++){
      for(int c = 0; c < colunas; c++){
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

   void reiniciar() {
    for (var c in _campos) {
      c.reiniciar();
    }
    _sortearMinas();
  }

  void revelarBombas() {
    for (var c in _campos) {
      c.revelarBomba();
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);  
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (qtdBombas > linhas * colunas) {
      return;
    }

    while (sorteadas < qtdBombas) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((c) => c.resolvido);
  }
}
