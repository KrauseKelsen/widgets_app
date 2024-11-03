import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {

  
  static const String name = 'counter_screen';


  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: const _CounterScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
        },
      ),
    );
  }
}

class _CounterScreen extends StatelessWidget {
  const _CounterScreen();


  @override
  Widget build(BuildContext context) {
    final int contador;
    contador = 0;
    return Center(
      child: Text('Valor: $contador', style: Theme.of(context).textTheme.titleLarge,),
    );
  }
}