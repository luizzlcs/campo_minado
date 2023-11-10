import 'package:campo_minado/components/controller_count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultadoWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool? venceu;
  final VoidCallback? onReiniciar;

  const ResultadoWidget({
    required this.venceu,
    required this.onReiniciar,
    super.key,
  });

  @override
  State<ResultadoWidget> createState() => _ResultadoWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _ResultadoWidgetState extends State<ResultadoWidget> {
  final counter = ControllerCount();
  Color? _getCor() {
    if (widget.venceu == null) {
      return Colors.yellow;
    } else if (widget.venceu == true) {
      return Colors.green[300];
    } else {
      return Colors.red[300];
    }
  }

  IconData _getIcon() {
    if (widget.venceu == null) {
      return Icons.sentiment_dissatisfied;
    } else if (widget.venceu == true) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  retunrInt() {
    final counter = ControllerCount();
    final inteiro = counter.count;
    return inteiro.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        tooltip: 'Aumentar',
                        onPressed: () {
                          widget.onReiniciar!();
                          context.read<ControllerCount>().incremetCount();
                        },
                        icon: const RotatedBox(
                          quarterTurns: 90,
                          child: Icon(Icons.expand_circle_down_outlined),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/bomba_1.jpeg'),
                          ),
                          AnimatedBuilder(
                            animation: counter,
                            builder: (context, child) {
                              return Text(
                                '${context.watch<ControllerCount>().count}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ],
                      ),
                      IconButton(                        
                        tooltip: 'Diminuir',
                        onPressed: () {
                          context.read<ControllerCount>().decrementCount();
                          widget.onReiniciar!();
                        },
                        icon: const Icon(Icons.expand_circle_down_outlined),
                      ),
                    ],
                  )
                ],
              ),
              CircleAvatar(
                backgroundColor: _getCor(),
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: widget.onReiniciar,
                    icon: Icon(
                      _getIcon(),
                      color: Colors.black,
                      size: 35,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*  @override
  Size get preferredSize => const Size.fromHeight(120); */
}
