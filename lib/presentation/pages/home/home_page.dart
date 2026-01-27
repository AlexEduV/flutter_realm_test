import 'package:flutter/material.dart'
    show
        AnimatedList,
        AnimatedListState,
        Animation,
        AppBar,
        Axis,
        BuildContext,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        Expanded,
        FloatingActionButton,
        GlobalKey,
        Icon,
        Icons,
        Padding,
        Row,
        Scaffold,
        SizeTransition,
        State,
        StatefulWidget,
        Text,
        Theme,
        Widget,
        WidgetsBindingObserver;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:realm/realm.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/utils/l10n.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_state.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/home_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

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
                //todo: finish widget as per design
                child: Row(
                  spacing: AppDimensions.minorS,
                  children: [
                    Text(AppLocalisations.results, style: AppTextStyles.roboto16),

                    Text(state.cars.length.toString()),
                  ],
                ),
              ),

              Expanded(
                child: AnimatedList(
                  key: _listKey,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(state.cars[index], animation, index);
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
      Car(ObjectId(), 'Tesla', model: 'Model Y', kilometers: 200),
    );
    final cars = serviceLocator<CarRepository>().getAllCars();

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
    serviceLocator<CarRepository>().deleteCarById(id);

    context.read<HomePageCubit>().removeCarAt(index);
  }
}
