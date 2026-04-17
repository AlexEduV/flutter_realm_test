import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/vehicle_specs/vehicle_specs_widget.dart';

class MockDetailsPageCubit extends Mock implements DetailsPageCubit {
  final bool isExpanded;

  MockDetailsPageCubit(this.isExpanded);

  @override
  DetailsPageState get state => DetailsPageState(
    isLoading: false,
    isVehicleSpecsExpanded: isExpanded,
    carColor: Colors.white,
  );

  @override
  Stream<DetailsPageState> get stream => const Stream.empty();
}

Widget buildVehicleSpecsWidgetUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()
    ..load({
      L10nKeys.vehicleSpecificationsSectionTitle: 'Vehicle specs',
      L10nKeys.vehicleSpecificationBody: 'Body',
      L10nKeys.vehicleSpecificationEngine: 'Engine',
      L10nKeys.vehicleSpecificationTransmission: 'Transmission',
      L10nKeys.vehicleSpecificationMileage: 'Mileage',
      L10nKeys.unknownLabel: 'Unknown',
      L10nKeys.vehicleSpecificationColor: 'Color',
      L10nKeys.vehicleSpecificationYear: 'Year',
    });

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Column(
        spacing: AppDimensions.normalL,
        children: [
          //Interactive
          VehicleSpecsWidget(car: CarEntity.empty()),
        ],
      ),
    ),
  );
}
