import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/core/di/injection_container.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_region_remote_data_source_impl.dart';
import 'package:test_futter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_regions_use_case.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../../common/extensions/context_extension_test.mocks.dart';
import 'region_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([FetchRegionsUseCase, GetAllRegionsUseCase])
void main() {
  final getIt = serviceLocator;

  late MockFetchRegionsUseCase mockFetchRegionsUseCase;
  late MockGetAllRegionsUseCase mockGetAllRegionsUseCase;
  late MockAppLocalisationsCubit mockAppLocalisationsCubit;

  setUp(() {
    mockFetchRegionsUseCase = MockFetchRegionsUseCase();
    mockGetAllRegionsUseCase = MockGetAllRegionsUseCase();
    mockAppLocalisationsCubit = MockAppLocalisationsCubit();

    getIt.registerSingleton<FetchRegionsUseCase>(mockFetchRegionsUseCase);
    getIt.registerSingleton<GetAllRegionsUseCase>(mockGetAllRegionsUseCase);
    getIt.registerSingleton<AppLocalisationsCubit>(mockAppLocalisationsCubit);
    getIt.registerSingleton<RegionRemoteDataSource>(MockRegionRemoteDataSourceImpl());
  });

  tearDown(() {
    getIt.unregister<FetchRegionsUseCase>();
    getIt.unregister<GetAllRegionsUseCase>();
    getIt.unregister<AppLocalisationsCubit>();
    getIt.unregister<RegionRemoteDataSource>();
  });

  test('init calls FetchRegionsUseCase and sets regions from GetAllRegionsUseCase', () async {
    final regionEntities = [const RegionEntity(locale: 'US'), const RegionEntity(locale: 'DE')];

    when(mockFetchRegionsUseCase.call()).thenAnswer((_) async {});
    when(mockGetAllRegionsUseCase.call()).thenReturn(regionEntities);

    await serviceLocator<RegionRemoteDataSource>().init();

    expect(MockRegionRemoteDataSourceImpl.regions, regionEntities);
    verify(mockFetchRegionsUseCase.call()).called(1);
    verify(mockGetAllRegionsUseCase.call()).called(1);
  });

  test('getAvailableCountries maps regions to RegionUiModel with localized names', () {
    MockRegionRemoteDataSourceImpl.regions = [
      const RegionEntity(locale: 'US'),
      const RegionEntity(locale: 'DE'),
    ];

    when(
      mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}US'),
    ).thenReturn('United States');
    when(
      mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}DE'),
    ).thenReturn('Germany');

    final result = serviceLocator<RegionRemoteDataSource>().getAvailableCountries();

    expect(result, [
      const RegionUiModel(countryName: 'United States', code: 'US'),
      const RegionUiModel(countryName: 'Germany', code: 'DE'),
    ]);

    verify(mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}US')).called(1);
    verify(mockAppLocalisationsCubit.getLocalisationByKey('${L10nKeys.countryPrefix}DE')).called(1);
  });
}
