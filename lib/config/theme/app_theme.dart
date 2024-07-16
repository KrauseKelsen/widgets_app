import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue, //0
  Colors.teal, //1
  Colors.green, //2
  Colors.red, //3
  Colors.purple, //4
  Colors.deepPurple, //5
  Colors.orange, //6
  Colors.pink, //7
  Colors.pinkAccent, //8
  Colors.yellow, //9
  Colors.yellowAccent, //10
  Colors.black, //11
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, 'Selected colors must be greater than 0'),
      assert(selectedColor < colorList.length, 'Selected colors must be greater than ${colorList.length - 1}');

  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: colorList[selectedColor], appBarTheme: const AppBarTheme(centerTitle: false));
}
