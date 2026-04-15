import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/dto/klipy_gif_dto.dart';
import 'package:test_flutter_project/data/repositories/gifs_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/remote/gifs_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/gif_entity.dart';

import 'gifs_repository_impl_test.mocks.dart';

@GenerateMocks([GifsRemoteDataSource])
void main() {
  late MockGifsRemoteDataSource mockRemoteDataSource;
  late GifsRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockGifsRemoteDataSource();
    repository = GifsRepositoryImpl(mockRemoteDataSource);
  });

  test('searchGifs calls remote data source and returns list of GifEntity', () async {
    final gifDtos = [
      KlipyGifDto(
        id: '1',
        title: 'Funny Cat',
        previewImageUrl: 'http://preview.com/cat.gif',
        imageUrl: 'http://image.com/cat.gif',
        width: 320.0,
        height: 240.0,
      ),
      KlipyGifDto(
        id: '2',
        title: 'Dancing Dog',
        previewImageUrl: 'http://preview.com/dog.gif',
        imageUrl: 'http://image.com/dog.gif',
        width: 400.0,
        height: 300.0,
      ),
    ];
    when(mockRemoteDataSource.searchGifs('funny')).thenAnswer((_) async => Right(gifDtos));

    final result = await repository.searchGifs('funny');

    // Extract the value from Either
    result.fold((failure) => fail('Expected Right, got Left: $failure'), (entities) {
      expect(entities.length, 2);
      expect(entities[0], equals(GifEntity.fromDto(gifDtos[0])));
      expect(entities[1], equals(GifEntity.fromDto(gifDtos[1])));
    });

    verify(mockRemoteDataSource.searchGifs('funny')).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getTrending calls remote data source and returns list of GifEntity', () async {
    final gifDtos = [
      KlipyGifDto(
        id: '3',
        title: 'Jumping Fox',
        previewImageUrl: 'http://preview.com/fox.gif',
        imageUrl: 'http://image.com/fox.gif',
        width: 500.0,
        height: 350.0,
      ),
    ];
    when(mockRemoteDataSource.getTrending()).thenAnswer((_) async => Right(gifDtos));

    final result = await repository.getTrending();

    result.fold((failure) => fail('Expected Right, got Left: $failure'), (entities) {
      expect(entities.length, 1);
      expect(entities[0], equals(GifEntity.fromDto(gifDtos[0])));
    });

    verify(mockRemoteDataSource.getTrending()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
