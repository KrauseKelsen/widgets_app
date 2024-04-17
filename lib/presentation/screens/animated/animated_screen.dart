import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedScreen extends StatefulWidget {
  static const String name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  double width = 50;
  double height = 50;

  Color color = Colors.indigo;

  double borderRadius = 10.0;

  void changeShape() {
    final random = Random();

    width =
        random.nextInt(300) + 120; // numero maximo aleatorio es 300 y minimo 50
    height =
        random.nextInt(300) + 120; // numero maximo aleatorio es 300 y minimo 50
    borderRadius =
        random.nextInt(100) + 20; // numero maximo aleatorio es 100 y minimo 10

    color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic, // tipo de animacion
          width: width <=0 ? 0: width, // validacion para que el random.nextInt no devuelva 0
          height: height <=0 ? 0: height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(borderRadius <=0 ? 0: borderRadius)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeShape,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
