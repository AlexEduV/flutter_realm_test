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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return HomeListItem(
            car: cars[index],
            onDismissed: () {
              realm.write(() {
                final car = realm.find<Car>(cars[index].id);

                if (car != null) {
                  realm.delete(car);
                }
              });

              setState(() {
                cars.removeAt(index);
              });
            },
          );
        },
        itemCount: cars.length,
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
}
