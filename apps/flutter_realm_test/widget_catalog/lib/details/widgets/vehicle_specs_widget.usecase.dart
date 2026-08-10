import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/features/details/widgets/vehicle_specs/vehicle_specs_widget.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';

class MockDetailsPageCubit extends Mock implements DetailsPageCubit {
  final bool isExpanded;

  MockDetailsPageCubit(this.isExpanded);

  @override
  DetailsPageState get state => DetailsPageState(
    isVehicleSpecsExpanded: isExpanded,
    carColor: Colors.white,
    car: CarEntity.empty(),
  );

  @override
  Stream<DetailsPageState> get stream => const Stream.empty();

  @override
  Future<void> close() async {}
}

Widget buildVehicleSpecsWidgetUseCase(BuildContext context, {bool isExpanded = true}) {
  final appLocalisationsCubit = AppLocalisationsCubit()
    ..load({
      DetailsPageLocaleKeys.vehicleSpecificationsSectionTitle: 'Vehicle specs',
      DetailsPageLocaleKeys.vehicleSpecificationBody: 'Body',
      DetailsPageLocaleKeys.vehicleSpecificationEngine: 'Engine',
      DetailsPageLocaleKeys.vehicleSpecificationTransmission: 'Transmission',
      DetailsPageLocaleKeys.vehicleSpecificationMileage: 'Mileage',
      L10nKeys.unknownLabel: 'Unknown',
      DetailsPageLocaleKeys.vehicleSpecificationColor: 'Color',
      DetailsPageLocaleKeys.vehicleSpecificationYear: 'Year',
    });

  return MultiBlocProvider(
    providers: [
      BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit),
      BlocProvider<DetailsPageCubit>(create: (_) => MockDetailsPageCubit(isExpanded)),
    ],
    child: Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Column(spacing: AppDimensions.normalL, children: [const VehicleSpecsWidget()]),
    ),
  );
}
