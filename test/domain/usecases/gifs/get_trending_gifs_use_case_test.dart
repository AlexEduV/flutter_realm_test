import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/core/network/server_failure.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/gifs/get_trending_gifs_use_case.dart';

import 'get_trending_gifs_use_case_test.mocks.dart';

@GenerateMocks([GifsRepository])
void main() {
  late MockGifsRepository mockRepository;
  late GetTrendingGifsUseCase useCase;

  setUp(() {
    mockRepository = MockGifsRepository();
    useCase = GetTrendingGifsUseCase(mockRepository);
  });

  test('should call getTrending on repository and return list of GifEntity', () async {
    final gifs = [
      GifEntity(
        id: '1',
        previewImageUrl: 'https://example.com/1.gif',
        imageUrl: 'https://example.com/1.gif',
        height: 750,
        width: 750,
        title: '1',
      ),
      GifEntity(
        id: '2',
        previewImageUrl: 'https://example.com/2.gif',
        imageUrl: 'https://example.com/2.gif',
        height: 750,
        width: 750,
        title: '1',
      ),
    ];
    when(mockRepository.getTrending()).thenAnswer((_) async => Right(gifs));

    final result = await useCase.call();

    result.fold((failure) => fail('Expected Right, got Left: $failure'), (entities) {
      expect(entities, equals(entities));
    });

    verify(mockRepository.getTrending()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return empty list when repository returns empty list', () async {
    when(
      mockRepository.getTrending(),
    ).thenAnswer((_) async => const Left(ServerFailure.notAvailable));

    final result = await useCase.call();

    result.fold((failure) {
      expect(failure, equals(ServerFailure.notAvailable));
    }, (entities) => fail('Expected Left, got Right: $entities'));

    verify(mockRepository.getTrending()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
