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
    final random = Random();

  double generateRandomDimension(int value1, int value2) {
    
    return (random.nextInt(value1) + value2).toDouble(); // numero maximo aleatorio es 300 y minimo 60
  }

  double generateRandomBorderRadius(int value1, int value2) {
    return (random.nextInt(value1) + value2).toDouble(); // numero maximo aleatorio es 300 y minimo 60
  }

  Color generateRandomColor(int r, int g, int b) {
    return (Color.fromRGBO(
        random.nextInt(r), random.nextInt(g), random.nextInt(b), 1)); // numero maximo aleatorio es 300 y minimo 60
  }

  void changeShape() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimatedContainer(
                width: generateRandomDimension(300, 60),
                height: generateRandomDimension(300, 60),
                color: generateRandomColor(255, 255, 255),
                borderRadius: generateRandomBorderRadius(100, 10),
                image: 'krause.png',
            ),
            const SizedBox(
              height: 20,
            ),
            _AnimatedContainer(
                width: generateRandomDimension(300, 60),
                height: generateRandomDimension(300, 60),
                color: generateRandomColor(255, 255, 255),
                borderRadius: generateRandomBorderRadius(100, 10),
                image: 'johara.png',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeShape,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}

class _AnimatedContainer extends StatelessWidget {
  const _AnimatedContainer({
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
    required this.image,
  });

  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic, // tipo de animacion
      width: width <= 0 ? 0 : width, // validacion para que el random.nextInt no devuelva 0
      height: height <= 0 ? 0 : height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius <= 0 ? 0 : borderRadius)),
      child: Image.asset('assets/$image', fit: BoxFit.contain),
    );
  }
}
