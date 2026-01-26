import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/repositories/car_repository_impl.dart';
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
  late final CarRepositoryImpl carRepositoryImpl;

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

    carRepositoryImpl = CarRepositoryImpl(realm);
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
          return _buildItem(cars[index], animation, index);
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
    carRepositoryImpl.addCar(Car(ObjectId(), 'Tesla', model: 'Y', kilometers: 200));
    cars = carRepositoryImpl.getAllCars();

    _listKey.currentState?.insertItem(cars.length - 1);
  }

  Widget _buildItem(Car car, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation, // Controls the vertical fold
      axis: Axis.vertical,
      child: HomeListItem(car: car, onDismissed: () => _handleDelete(car, index)),
    );
  }

  void _handleDelete(Car carToDelete, int index) {
    // 1. Capture the data while the object is still valid
    final ObjectId id = carToDelete.id;

    // 2. Animate out using a "Snapshot" instance of the same widget
    _listKey.currentState?.removeItem(
      index,
      (context, animation) =>
          SizeTransition(sizeFactor: animation, child: HomeListItem(car: null, onDismissed: null)),
      duration: const Duration(milliseconds: 300),
    );

    // 3. Delete once
    carRepositoryImpl.deleteCarById(id);

    setState(() {
      cars.removeAt(index);
    });
  }
}
