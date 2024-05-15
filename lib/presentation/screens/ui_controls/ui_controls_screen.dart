import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {
  static const String name = 'ui_constrols_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Controls'),
      ),
      body: const _UiControlsView(),
    );
  }
}

enum Transportation { car, plane, boat, submarine }

class _UiControlsView extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

class _UiControlsViewState extends State<_UiControlsView> {
  bool isDeveloper = true;
  Transportation selectedTransportation = Transportation.car;
  bool wantsBreakfast = true;
  bool wantsLunch = false;
  bool wantsDinner = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(), //movimiento de rebote de iOS
      children: [
        SwitchListTile(
            value: isDeveloper,
            title: const Text('Developer Mode'),
            subtitle: const Text('Controles adicionales'),
            onChanged: (value) => setState(() {
                  isDeveloper = !isDeveloper;
                })),
        ExpansionTile(
          title: const Text('Vehiculo de transporte'),
          subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
              value: Transportation.car,
              title: const Text('By Car'),
              subtitle: const Text('Viajar por carro'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),
            RadioListTile(
              value: Transportation.boat,
              title: const Text('By Boat'),
              subtitle: const Text('Viajar por bote'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),
            RadioListTile(
              value: Transportation.plane,
              title: const Text('By Plane'),
              subtitle: const Text('Viajar por avion'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),
            RadioListTile(
              value: Transportation.submarine,
              title: const Text('By Submarine'),
              subtitle: const Text('Viajar por submarino'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
          ],
        ),


        CheckboxListTile(
          value: wantsBreakfast, 
          title: const Text('Desayuno?'),
          onChanged: (value) => {
          setState(() {
            wantsBreakfast = !wantsBreakfast;
          })
        }),


        CheckboxListTile(
          value: wantsLunch, 
          title: const Text('Almuerzo?'),
          onChanged: (value) => {
          setState(() {
            wantsLunch = !wantsLunch;
          })
        }),


        CheckboxListTile(
          value: wantsDinner, 
          title: const Text('Cena?'),
          onChanged: (value) => {
          setState(() {
            wantsDinner = !wantsDinner;
          })
        }),
      ],
    );
  }
}
