import 'package:campo_minado/components/controller_count.dart';
import 'package:campo_minado/screens/campo_minado_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ControllerCount(),)
      ],
      child: const CampoMinadoApp(),
    ),
  );
}
