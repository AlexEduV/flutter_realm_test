import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_region_service.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_regions_use_case.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../common/extensions/context_extension_test.mocks.dart'; // for serviceLocator
import 'mock_region_service_test.mocks.dart';

@GenerateMocks([FetchRegionsUseCase, GetAllRegionsUseCase])
void main() {
  final getIt = serviceLocator;

  late MockFetchRegionsUseCase mockFetchRegionsUseCase;
  late MockGetAllRegionsUseCase mockGetAllRegionsUseCase;
  late MockAppLocalisationsCubit mockAppLocalisationsCubit;

  setUp(() {
    getIt.reset();
    mockFetchRegionsUseCase = MockFetchRegionsUseCase();
    mockGetAllRegionsUseCase = MockGetAllRegionsUseCase();
    mockAppLocalisationsCubit = MockAppLocalisationsCubit();

    getIt.registerSingleton<FetchRegionsUseCase>(mockFetchRegionsUseCase);
    getIt.registerSingleton<GetAllRegionsUseCase>(mockGetAllRegionsUseCase);
    getIt.registerSingleton<AppLocalisationsCubit>(mockAppLocalisationsCubit);
  });

  test('init calls FetchRegionsUseCase and sets regions from GetAllRegionsUseCase', () async {
    final regionEntities = [const RegionEntity(locale: 'US'), const RegionEntity(locale: 'DE')];

    when(mockFetchRegionsUseCase.call()).thenAnswer((_) async {});
    when(mockGetAllRegionsUseCase.call()).thenReturn(regionEntities);

    await MockRegionService.init();

    expect(MockRegionService.regions, regionEntities);
    verify(mockFetchRegionsUseCase.call()).called(1);
    verify(mockGetAllRegionsUseCase.call()).called(1);
  });

  test('getAvailableCountries maps regions to RegionUiModel with localized names', () {
    MockRegionService.regions = [
      const RegionEntity(locale: 'US'),
      const RegionEntity(locale: 'DE'),
    ];

    when(
      mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}US'),
    ).thenReturn('United States');
    when(
      mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}DE'),
    ).thenReturn('Germany');

    final result = MockRegionService.getAvailableCountries();

    expect(result, [
      const RegionUiModel(countryName: 'United States', code: 'US'),
      const RegionUiModel(countryName: 'Germany', code: 'DE'),
    ]);

    verify(mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}US')).called(1);
    verify(mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}DE')).called(1);
  });
}
