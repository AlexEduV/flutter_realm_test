/*
todo: there's not much of a point for maintaining these tests, because they have too many dependencies;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_flutter_project/presentation/pages/details/widgets/vehicle_specs_widget.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../common/constants/app_dimensions.dart';
import '../../../bloc/l10n/app_localisations_cubit.dart';

class MockDetailsPageCubit extends Mock implements DetailsPageCubit {
  final BuildContext context;

  MockDetailsPageCubit(this.context);

  @override
  DetailsPageState get state => DetailsPageState(
    isLoading: false,
    isVehicleSpecsExpanded: context.knobs.boolean(label: 'Is expanded', initialValue: true),
  );

  @override
  Stream<DetailsPageState> get stream => const Stream.empty();
}

Widget buildVehicleSpecsWidgetUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

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

 */
