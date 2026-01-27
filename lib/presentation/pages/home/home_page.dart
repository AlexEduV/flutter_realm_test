import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:realm/realm.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/utils/l10n.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_state.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/home_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, super.key});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: AppDimensions.normalM,
                  top: AppDimensions.normalM,
                ),
                child: Row(
                  spacing: AppDimensions.minorL,
                  children: [
                    Text(AppLocalisations.results, style: AppTextStyles.roboto16),

                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                      padding: EdgeInsets.all(AppDimensions.minorL),
                      child: Text(
                        state.cars.length.toString(),
                        style: AppTextStyles.roboto16.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: state.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : AnimatedList(
                        key: state.cars.isEmpty ? const ValueKey('empty') : _listKey,
                        itemBuilder: (context, index, animation) {
                          final car = state.cars[index];

                          return _buildItem(CarExtensions.fromEntity(car), animation, index);
                        },
                        initialItemCount: state.cars.length,
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCarToBase,
        tooltip: AppLocalisations.addCarButtonTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addCarToBase() {
    serviceLocator<CarRepository>().addCar(
      CarEntity(
        carId: '3',
        model: 'Model Y',
        manufacturer: 'Tesla',
        isVerified: false,
        isHotPromotion: false,
      ),
    );
    final cars = serviceLocator<CarRepository>().getAllCars();

    _listKey.currentState?.insertItem(cars.length - 1);
    context.read<HomePageCubit>().updateCars(cars);
  }

  Widget _buildItem(Car car, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation, // Controls the vertical fold
      axis: Axis.vertical,
      child: HomeListItem(
        car: CarEntity.fromSchema(car),
        onDismissed: () => _handleDelete(car, index),
      ),
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
    serviceLocator<CarRepository>().deleteCarById(id);

    context.read<HomePageCubit>().removeCarAt(index);
  }
}
