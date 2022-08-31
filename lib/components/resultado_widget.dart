import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final VoidCallback onReiniciar;

  ResultadoWidget({Key? key, required this.venceu, required this.onReiniciar})
      : super(key: key);

  Color _getCor() {
    if (venceu == null) {
      return Colors.yellow;
    } else if (venceu == true) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_dissatisfied;
    } else if (venceu == true) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 145, 108, 108),
      child: SafeArea(
        child: Center(
          child: Container(
            child: CircleAvatar(
              backgroundColor: _getCor(),
              child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: onReiniciar,
                icon: Icon(
                  _getIcon(),
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
