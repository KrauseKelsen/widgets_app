import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue, //1
  Colors.teal, //2
  Colors.green, //3
  Colors.red, //4
  Colors.purple, //5
  Colors.deepPurple, //6
  Colors.orange, //7
  Colors.pink, //8
  Colors.pinkAccent, //9
  Colors.yellow, //10
  Colors.yellowAccent, //11
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, 'Selected colors must be greater than 0'),
      assert(selectedColor < colorList.length, 'Selected colors must be greater than ${colorList.length - 1}');

  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: colorList[selectedColor], appBarTheme: const AppBarTheme(centerTitle: false));
}
