import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const String name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
        content: const Text('Hallo Welt'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(label: 'Ok!', onPressed: () {}));

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                  'Commodo Lorem reprehenderit labore id. Eu elit proident reprehenderit est et labore consectetur aliquip minim sunt id Lorem magna. Eiusmod nulla aliqua consectetur ipsum proident in.'),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    context
                        .pop(); // esta extesion al pop desde el context se debe gracias al GoRouter
                  },
                ),
                FilledButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    context
                        .pop(); // esta extesion al pop desde el context se debe gracias al GoRouter
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbards y Diálogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              child: const Text('Licencias usadas'),
              onPressed: () {
                //esta sentencia nos muestra las licencias que usa mi proyecto
                showAboutDialog(
                  context: context, 
                  children: [
                    const Text(
                    ' Labore ea Lorem est aliquip ex minim aliquip laborum dolor nisi. Velit elit anim esse eiusmod ea.Enim labore et non nostrud ex officia cillum sunt enim ex mollit nulla. Eiusmod consectetur nostrud in aliquip velit ipsum incididunt dolore consectetur do ut.',
                    )
                  ]
                );
              },
            ),
            FilledButton.tonal(
                onPressed: () => openDialog(context),
                child: const Text('Mostrar diálogo')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
