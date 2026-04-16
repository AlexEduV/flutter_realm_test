import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/vehicle_specs_widget.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../common/constants/app_dimensions.dart';
import '../../../../l10n/l10n_keys.dart';
import '../../../bloc/l10n/app_localisations_cubit.dart';

class MockDetailsPageCubit extends Mock implements DetailsPageCubit {
  final BuildContext context;

  MockDetailsPageCubit(this.context);

  @override
  DetailsPageState get state => DetailsPageState(
    isLoading: false,
    //todo: knobs are not available from inside the mock
    isVehicleSpecsExpanded: context.knobs.boolean(label: 'Is expanded', initialValue: true),
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

  final detailsPageCubit = MockDetailsPageCubit(context);

  return MultiBlocProvider(
    providers: [
      BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit),
      BlocProvider<DetailsPageCubit>(create: (_) => detailsPageCubit),
    ],
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
