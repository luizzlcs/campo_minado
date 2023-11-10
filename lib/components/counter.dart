
import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int _count = 15;

  int get count => _count;
  incremetCount(){
    if(_count >=25){
      return;
    }
    _count++;
    notifyListeners();
  }
  decrementCount(){
    if(_count <=1){
      return;
    }
    _count--;
    notifyListeners();
  }

  void imprimir(){
    debugPrint('$_count');
  }
  
}