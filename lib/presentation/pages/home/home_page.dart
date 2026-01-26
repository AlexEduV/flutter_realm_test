import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/home_list_item.dart';

import '../../../data/models/scheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final config = Configuration.local(
    [Car.schema, Person.schema],
    schemaVersion: 2,
    migrationCallback: (migration, oldVersion) {
      //add object id
      if (oldVersion < 2) {
        final oldCars = migration.oldRealm.all('Car');

        for (final oldCar in oldCars) {
          final newCar = migration.findInNewRealm<Car>(oldCar);
          if (newCar != null) {
            newCar.id = ObjectId();
          }
        }
      }
    },
  );
  late Realm realm;

  List<Car> cars = [];

  @override
  void initState() {
    super.initState();

    realm = Realm(config);
    cars = realm.all<Car>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: AnimatedList(
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            child: _buildItem(cars[index], animation, index),
          );
        },
        initialItemCount: cars.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCarToBase,
        tooltip: 'Add A car',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addCarToBase() {
    realm.write(() {
      realm.add(Car(ObjectId(), 'Tesla', model: 'Y', kilometers: 200));
    });

    setState(() {
      cars = realm.all<Car>().toList();
    });
  }

  Widget _buildItem(Car car, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation, // Controls the vertical fold
      axis: Axis.vertical,
      child: HomeListItem(car: car, onDismissed: () => _handleDelete(car, index)),
    );
  }

  void _handleDelete(Car carToDelete, int index) {
    // 1. Capture the item to show it during animation
    final Car removedItem = carToDelete;

    // 2. Trigger the folding animation
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation, index),
      duration: const Duration(milliseconds: 300),
    );

    // 3. Delete from Realm and local state
    realm.write(() {
      final liveCar = realm.find<Car>(carToDelete.id);
      if (liveCar != null) realm.delete(liveCar);
    });

    // setState(() {
    //   cars.removeAt(index);
    // });
  }
}
