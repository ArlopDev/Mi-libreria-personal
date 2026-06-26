
import 'package:flutter/material.dart';
import 'package:mi_libreria_flutter/pruebas/anim/animated_builder_prob_1.dart';

void main(){
  runApp(const MiLibreria());
}

class MiLibreria extends StatelessWidget {

  const MiLibreria();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AnimatedBuilderProb1(),
    );
  }
}