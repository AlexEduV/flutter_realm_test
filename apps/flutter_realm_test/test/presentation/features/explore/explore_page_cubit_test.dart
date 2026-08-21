import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/promo_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/usecases/articles/fetch_articles_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_state.dart';

import '../../../data/data_sources/remote/article_remote_data_source_impl_test.mocks.dart';
import 'explore_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SyncCarsUseCase>(),
  MockSpec<WatchCarsUseCase>(),
  MockSpec<FetchArticlesUseCase>(),
  MockSpec<GetCarByIdUseCase>(),
])
void main() {
  late MockLoggingService mockLoggingService;
  late MockSyncCarsUseCase mockSyncCarsUseCase;
  late MockWatchCarsUseCase mockWatchCarsUseCase;
  late MockFetchArticlesUseCase mockFetchArticlesUseCase;
  late MockGetCarByIdUseCase mockGetCarByIdUseCase;

  late ExplorePageCubit cubit;

  final carList = [
    CarEntity(
      id: ObjectId(),
      carId: '1',
      model: 'Model S',
      manufacturer: 'Tesla',
      isVerified: true,
      type: 'car',
      engine: EngineEntity(type: FuelType.ev.name),
      bodyType: BodyType.sedan.name,
      transmissionType: TransmissionType.automatic.name,
    ),
    CarEntity(
      id: ObjectId(),
      carId: '2',
      model: 'Civic',
      manufacturer: 'Honda',
      isVerified: false,
      promoType: PromoType.limitedTimeOffer,
      type: 'car',
      engine: EngineEntity(type: FuelType.hybrid.name),
      bodyType: BodyType.sedan.name,
      transmissionType: TransmissionType.automatic.name,
    ),
  ];

  setUp(() {
    mockLoggingService = MockLoggingService();
    mockWatchCarsUseCase = MockWatchCarsUseCase();
    mockSyncCarsUseCase = MockSyncCarsUseCase();
    mockFetchArticlesUseCase = MockFetchArticlesUseCase();
    mockGetCarByIdUseCase = MockGetCarByIdUseCase();
    cubit = ExplorePageCubit(
      mockLoggingService,
      mockWatchCarsUseCase,
      mockSyncCarsUseCase,
      mockFetchArticlesUseCase,
      mockGetCarByIdUseCase,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  blocTest<ExplorePageCubit, ExplorePageState>(
    'should init',
    setUp: () {
      when(mockSyncCarsUseCase.call()).thenAnswer((_) async => {});
      when(mockWatchCarsUseCase.call()).thenAnswer((_) => Stream.value(carList));
      when(mockFetchArticlesUseCase.call()).thenAnswer((_) async => []);
    },
    build: () {
      return cubit;
    },
    act: (cubit) => cubit.init(),
    expect: () => [
      // sync started
      isA<ExplorePageState>()
          .having((s) => s.isLoading, 'isLoading', true)
          .having((s) => s.isArticleListLoading, 'isArticleListLoading', true),
      // sync done
      isA<ExplorePageState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.isArticleListLoading, 'isArticleListLoading', true),
      // articles done (articles:[] equals default so that emit is deduplicated;
      // this state reflects isArticleListLoading flipping to false)
      isA<ExplorePageState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.isArticleListLoading, 'isArticleListLoading', false),
      // cars from watch stream (cubit maps isShown: true for all non-hidden cars)
      isA<ExplorePageState>()
          .having((s) => s.isArticleListLoading, 'isArticleListLoading', false)
          .having((s) => s.cars.map((c) => c.carId).toList(), 'car ids', ['1', '2'])
          .having((s) => s.cars.every((c) => c.isShown), 'all visible', true),
    ],
    verify: (_) {
      verify(mockWatchCarsUseCase.call()).called(1);
      verify(mockSyncCarsUseCase.call()).called(1);
    },
  );

  blocTest<ExplorePageCubit, ExplorePageState>(
    'updateCars emits state with new cars',
    build: () => cubit,
    act: (cubit) => cubit.updateCars(carList),
    expect: () => [isA<ExplorePageState>().having((s) => s.cars, 'cars', carList)],
  );

  blocTest<ExplorePageCubit, ExplorePageState>(
    'removeCarAt removes the car at the given index',
    build: () => cubit,
    seed: () => ExplorePageState(cars: carList),
    act: (cubit) => cubit.removeCarById('1'),
    expect: () => [
      isA<ExplorePageState>()
          .having((s) => s.cars.length, 'cars.length', 2)
          .having((s) => s.cars.first.isShown, 'deleted car', false),
    ],
  );

  group('isCarExistsById', () {
    test('returns false for null carId', () {
      expect(cubit.isCarExistsById(null), isFalse);
    });

    test('returns true when car is found', () {
      when(mockGetCarByIdUseCase.call('1')).thenReturn(carList.first);
      expect(cubit.isCarExistsById('1'), isTrue);
    });

    test('returns false when car is not found', () {
      when(mockGetCarByIdUseCase.call('99')).thenReturn(null);
      expect(cubit.isCarExistsById('99'), isFalse);
    });
  });

  group('getLastSeenCarById', () {
    test('returns null for null carId', () {
      expect(cubit.getLastSeenCarById(null), isNull);
    });

    test('returns car entity when found', () {
      when(mockGetCarByIdUseCase.call('1')).thenReturn(carList.first);
      expect(cubit.getLastSeenCarById('1'), carList.first);
    });

    test('returns null and logs error when car is not found', () {
      when(mockGetCarByIdUseCase.call('99')).thenReturn(null);
      expect(cubit.getLastSeenCarById('99'), isNull);
      verify(mockLoggingService.error(any)).called(1);
    });
  });

  group('hoverArticle', () {
    final article = ArticleEntity.empty();

    blocTest<ExplorePageCubit, ExplorePageState>(
      'sets isHovering to true for the matching article',
      build: () => cubit,
      seed: () => ExplorePageState(articles: [article]),
      act: (cubit) => cubit.hoverArticle(article.id, true),
      expect: () => [
        isA<ExplorePageState>().having(
          (s) => s.articles.first.isHovering,
          'isHovering',
          true,
        ),
      ],
    );

    blocTest<ExplorePageCubit, ExplorePageState>(
      'sets isHovering to false for the matching article',
      build: () => cubit,
      seed: () => ExplorePageState(articles: [article.copyWith(isHovering: true)]),
      act: (cubit) => cubit.hoverArticle(article.id, false),
      expect: () => [
        isA<ExplorePageState>().having(
          (s) => s.articles.first.isHovering,
          'isHovering',
          false,
        ),
      ],
    );

    blocTest<ExplorePageCubit, ExplorePageState>(
      'does not emit when no article matches the id',
      build: () => cubit,
      seed: () => ExplorePageState(articles: [article]),
      act: (cubit) => cubit.hoverArticle('other-id', true),
      expect: () => [],
    );
  });
}
