import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/repositories/car_repository_impl.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_state.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/home_list_item.dart';

import '../../../data/models/scheme.dart';
import '../../bloc/home/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
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

  @override
  void initState() {
    super.initState();

    realm = Realm(config);
    carRepositoryImpl = CarRepositoryImpl(realm);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cars = carRepositoryImpl.getAllCars();
      context.read<HomePageCubit>().updateCars(cars);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return AnimatedList(
            key: _listKey,
            itemBuilder: (context, index, animation) {
              return _buildItem(state.cars[index], animation, index);
            },
            initialItemCount: state.cars.length,
          );
        },
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
    final cars = carRepositoryImpl.getAllCars();

    _listKey.currentState?.insertItem(cars.length - 1);
    context.read<HomePageCubit>().updateCars(cars);
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

    context.read<HomePageCubit>().removeCarAt(index);
  }
}
