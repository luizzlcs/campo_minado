import 'package:flutter/material.dart';

class HowToPlayDialog extends StatelessWidget {
  const HowToPlayDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Como Jogar Campo Minado 💣',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildInstructionStep(
              "🎯 Objetivo:",
              "Encontre todas as casas sem minas!\n"
              "Use os números para descobrir onde estão as bombas.",
            ),
            const SizedBox(height: 10),
            _buildInstructionStep(
              "🖱️ Comandos:",
              "• Toque rápido: Abre a casa\n"
              "• Toque longo: Marca/Desmarca com bandeira (🚩)",
            ),
            const SizedBox(height: 10),
            _buildInstructionStep(
              "🔍 Dicas dos Números:",
              "Cada número mostra quantas minas estão\n"
              "escondidas nas casas vizinhas!",
            ),
            const SizedBox(height: 10),
            _buildExampleSection(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendi! Vamos jogar!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionStep(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }

  Widget _buildExampleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Exemplo Prático:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildExampleCell("1", Colors.white),
            const SizedBox(width: 5),
            const Text("= 1 mina nas casas ao redor"),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            _buildExampleCell("🚩", Colors.red),
            const SizedBox(width: 5),
            const Text("= Casa marcada com possível mina"),
          ],
        ),
      ],
    );
  }

  Widget _buildExampleCell(String text, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.purple,
        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}