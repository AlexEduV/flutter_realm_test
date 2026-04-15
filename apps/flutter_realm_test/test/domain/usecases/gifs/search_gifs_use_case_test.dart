import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/gif_entity.dart';
import 'package:test_flutter_project/domain/usecases/gifs/search_gifs_use_case.dart';

import 'get_trending_gifs_use_case_test.mocks.dart';

void main() {
  late MockGifsRepository mockRepository;
  late SearchGifsUseCase useCase;

  setUp(() {
    mockRepository = MockGifsRepository();
    useCase = SearchGifsUseCase(mockRepository);
  });

  test(
    'should call searchGifs on repository with correct query and return list of GifEntity',
    () async {
      final query = 'funny cats';
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
      when(mockRepository.searchGifs(query)).thenAnswer((_) async => Right(gifs));

      final result = await useCase.call(query);

      result.fold((failure) => fail('Expected Right, got Left: $failure'), (entities) {
        expect(entities, equals(gifs));
      });

      verify(mockRepository.searchGifs(query)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return empty list when repository returns empty list', () async {
    final query = 'no results';
    when(mockRepository.searchGifs(query)).thenAnswer((_) async => const Right([]));

    final result = await useCase.call(query);

    result.fold((failure) => fail('Expected Right, got Left: $failure'), (entities) {
      expect(entities, isEmpty);
    });

    verify(mockRepository.searchGifs(query)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
