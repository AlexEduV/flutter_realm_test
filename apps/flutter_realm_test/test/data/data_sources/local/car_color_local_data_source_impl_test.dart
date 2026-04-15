import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/data/data_sources/local/car_color_local_data_source_impl.dart';

void main() {
  group('CarColorLocalDataSourceImpl', () {
    late CarColorLocalDataSourceImpl dataSource;

    setUp(() {
      dataSource = CarColorLocalDataSourceImpl();
    });

    test('getColors returns all expected color keys', () {
      final colors = dataSource.getColors();

      expect(
        colors.keys,
        containsAll([
          'red',
          'pink',
          'purple',
          'deepPurple',
          'indigo',
          'blue',
          'lightBlue',
          'cyan',
          'teal',
          'green',
          'lightGreen',
          'lime',
          'yellow',
          'white',
          'orange',
          'deepOrange',
          'brown',
          'grey',
          'blueGrey',
          'black',
        ]),
      );
      expect(colors.length, 20);
    });

    test('getColors returns correct Color values', () {
      final colors = dataSource.getColors();

      expect(colors['red'], Colors.red);
      expect(colors['pink'], Colors.pink);
      expect(colors['purple'], Colors.purple);
      expect(colors['deepPurple'], Colors.deepPurple);
      expect(colors['indigo'], Colors.indigo);
      expect(colors['blue'], Colors.blue);
      expect(colors['lightBlue'], Colors.lightBlue);
      expect(colors['cyan'], Colors.cyan);
      expect(colors['teal'], Colors.teal);
      expect(colors['green'], Colors.green);
      expect(colors['lightGreen'], Colors.lightGreen);
      expect(colors['lime'], Colors.lime);
      expect(colors['yellow'], Colors.yellow);
      expect(colors['white'], Colors.white);
      expect(colors['orange'], Colors.orange);
      expect(colors['deepOrange'], Colors.deepOrange);
      expect(colors['brown'], Colors.brown);
      expect(colors['grey'], Colors.grey);
      expect(colors['blueGrey'], Colors.blueGrey);
      expect(colors['black'], Colors.black);
    });

    test('getColors returns a modifiable map (by default)', () {
      final colors = dataSource.getColors();
      colors['custom'] = Colors.amber;
      expect(colors['custom'], Colors.amber);
    });
  });
}
