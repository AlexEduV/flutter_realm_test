import 'package:flutter/material.dart';

import '../../../domain/data_sources/local/car_colors_local_data_source.dart';

class CarColorLocalDataSourceImpl implements CarColorLocalDataSource {
  final Map<String, Color> _colors = {
    'red': Colors.red,
    'pink': Colors.pink,
    'purple': Colors.purple,
    'deepPurple': Colors.deepPurple,
    'indigo': Colors.indigo,
    'blue': Colors.blue,
    'lightBlue': Colors.lightBlue,
    'cyan': Colors.cyan,
    'teal': Colors.teal,
    'green': Colors.green,
    'lightGreen': Colors.lightGreen,
    'lime': Colors.lime,
    'yellow': Colors.yellow,
    'white': Colors.white,
    'orange': Colors.orange,
    'deepOrange': Colors.deepOrange,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'blueGrey': Colors.blueGrey,
    'black': Colors.black,
  };

  @override
  Map<String, Color> getColors() {
    return _colors;
  }
}
