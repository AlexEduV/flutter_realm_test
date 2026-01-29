import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page_state.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/explore_list_item.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/explore_section_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../common/extensions/car_scheme_extension.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({required this.title, super.key});

  final String title;

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with WidgetsBindingObserver {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  double _exploreHeight = 140; // initial height

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  //todo: it's not working correctly, since the widget bounces back even if there's enough room for user's scroll
  void _onScroll() {
    double offset = _scrollController.offset;
    double minHeight = 60;
    double maxHeight = 140;
    double newHeight = (maxHeight - offset).clamp(minHeight, maxHeight);
    if (newHeight != _exploreHeight) {
      setState(() {
        _exploreHeight = newHeight;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.headerColor,
        title: Text(widget.title, style: AppTextStyles.zonaPro30White),
        actions: [
          IconButton(
            //todo: move to cubit & probably route manager
            onPressed: () {
              context.go(AppRoutes.home + AppRoutes.search);
            },
            icon: Icon(Icons.search, size: 32, color: Colors.white),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: AppDimensions.normalM),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: _exploreHeight,
            decoration: BoxDecoration(
              color: AppColors.headerColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.normalL),
                bottomRight: Radius.circular(AppDimensions.normalL),
              ),
            ),
            padding: EdgeInsets.only(left: AppDimensions.normalM, bottom: 40, top: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: AppDimensions.normalL,
                children: [
                  ExploreSectionItem(height: _exploreHeight),
                  ExploreSectionItem(height: _exploreHeight),
                  ExploreSectionItem(height: _exploreHeight),
                  //todo: the sizedBox was added just for the padding. It's not an ideal solution
                  SizedBox(),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.normalM, top: AppDimensions.normalM),
            child: Text(AppLocalisations.recommendedSectionTitle, style: AppTextStyles.zonaPro18),
          ),

          BlocBuilder<ExplorePageCubit, ExplorePageState>(
            builder: (context, state) {
              return Expanded(
                child: state.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : AnimatedList(
                        key: state.cars.isEmpty ? const ValueKey('empty') : _listKey,
                        itemBuilder: (context, index, animation) {
                          final car = state.cars[index];

                          return _buildItem(CarExtensions.fromEntity(car), animation, index);
                        },
                        initialItemCount: state.cars.length,
                        controller: _scrollController,
                      ),
              );
            },
          ),
        ],
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
    context.read<ExplorePageCubit>().updateCars(cars);
  }

  Widget _buildItem(Car car, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation, // Controls the vertical fold
      axis: Axis.vertical,
      child: ExploreListItem(
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
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ExploreListItem(car: null, onDismissed: null),
      ),
      duration: const Duration(milliseconds: 300),
    );

    // 3. Delete once
    serviceLocator<CarRepository>().deleteCarById(id);

    context.read<ExplorePageCubit>().removeCarAt(index);
  }
}
