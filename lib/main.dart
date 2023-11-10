import 'package:campo_minado/components/controller_count.dart';
import 'package:campo_minado/screens/campo_minado_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ControllerCount>(
            create: (context) => ControllerCount(),
          )
        ],
        child: LayoutBuilder(
          builder: (context, constraints) => Consumer<ControllerCount>(
            builder: (context, value, child) => CampoMinadoApp(
              constraints: constraints,
              bombas: context.watch<ControllerCount>().count,
            ),
          ),
        ),
      ),
    ),
  );
}
