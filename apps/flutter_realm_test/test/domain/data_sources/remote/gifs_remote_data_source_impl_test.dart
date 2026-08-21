import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/server_failure.dart';
import 'package:test_flutter_project/data/data_sources/remote/gifs_remote_data_source_impl.dart';
import 'package:test_flutter_project/data/network/app_http_client.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import 'gifs_remote_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AppHttpClient>(), MockSpec<LoggingService>()])
void main() {
  late MockAppHttpClient mockClient;
  late MockLoggingService mockLoggingService;
  late GifsRemoteDataSourceImpl dataSource;

  const apiKey = 'test-key';

  setUp(() {
    mockClient = MockAppHttpClient();
    mockLoggingService = MockLoggingService();
    dataSource = GifsRemoteDataSourceImpl(mockClient, apiKey, mockLoggingService);
  });

  Map<String, dynamic> gifJson({String id = '1', String title = 'Funny Cat'}) => {
        'id': id,
        'title': title,
        'file': {
          'sm': {'gif': {'url': 'https://sm.gif', 'width': 200, 'height': 150}},
          'xs': {'gif': {'url': 'https://xs.gif', 'width': 100, 'height': 75}},
        },
      };

  String successResponse({List<Map<String, dynamic>>? items}) {
    return jsonEncode({
      'data': {'data': items ?? [gifJson()]},
    });
  }

  group('searchGifs', () {
    test('returns parsed gif list on success', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => Right(successResponse()));

      final result = await dataSource.searchGifs('cat');

      result.fold(
        (failure) => fail('Expected Right, got Left: $failure'),
        (gifs) {
          expect(gifs.length, 1);
          expect(gifs.first.id, '1');
          expect(gifs.first.title, 'Funny Cat');
          expect(gifs.first.imageUrl, 'https://sm.gif');
          expect(gifs.first.previewImageUrl, 'https://xs.gif');
          expect(gifs.first.width, 200.0);
          expect(gifs.first.height, 150.0);
        },
      );
    });

    test('returns empty list when data array is empty', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => Right(successResponse(items: [])));

      final result = await dataSource.searchGifs('nothing');

      result.fold(
        (failure) => fail('Expected Right, got Left'),
        (gifs) => expect(gifs, isEmpty),
      );
    });

    test('passes query and limit as URL params', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => Right(successResponse()));

      await dataSource.searchGifs('dogs', limit: 5);

      final captured = verify(
        mockClient.get(captureAny, logUrl: anyNamed('logUrl')),
      ).captured.single as Uri;

      expect(captured.queryParameters['q'], 'dogs');
      expect(captured.queryParameters['limit'], '5');
    });

    test('encodes API key into the request URL', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => Right(successResponse()));

      await dataSource.searchGifs('cats');

      final captured = verify(
        mockClient.get(captureAny, logUrl: anyNamed('logUrl')),
      ).captured.single as Uri;

      expect(captured.path, contains(apiKey));
    });

    test('propagates network failure from client', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => const Left(ServerFailure.noNetwork));

      final result = await dataSource.searchGifs('cat');

      expect(result, const Left(ServerFailure.noNetwork));
    });

    test('returns notAvailable and logs error on malformed JSON', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => const Right('not valid json {{{'));

      final result = await dataSource.searchGifs('cat');

      expect(result, const Left(ServerFailure.notAvailable));
      verify(mockLoggingService.error(any, error: anyNamed('error'), stackTrace: anyNamed('stackTrace'))).called(1);
    });

    test('returns notAvailable and logs error when data structure is unexpected', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => Right(jsonEncode({'wrong': 'shape'})));

      final result = await dataSource.searchGifs('cat');

      expect(result, const Left(ServerFailure.notAvailable));
      verify(mockLoggingService.error(any, error: anyNamed('error'), stackTrace: anyNamed('stackTrace'))).called(1);
    });
  });

  group('getTrending', () {
    test('returns parsed gif list on success', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => Right(successResponse(items: [gifJson(id: '42', title: 'Trending')])));

      final result = await dataSource.getTrending();

      result.fold(
        (failure) => fail('Expected Right, got Left: $failure'),
        (gifs) {
          expect(gifs.length, 1);
          expect(gifs.first.id, '42');
          expect(gifs.first.title, 'Trending');
        },
      );
    });

    test('encodes API key into the request URL', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => Right(successResponse()));

      await dataSource.getTrending();

      final captured = verify(
        mockClient.get(captureAny, logUrl: anyNamed('logUrl')),
      ).captured.single as Uri;

      expect(captured.path, contains(apiKey));
    });

    test('propagates network failure from client', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => const Left(ServerFailure.internalError));

      final result = await dataSource.getTrending();

      expect(result, const Left(ServerFailure.internalError));
    });

    test('returns notAvailable and logs error on malformed JSON', () async {
      when(mockClient.get(any, logUrl: anyNamed('logUrl')))
          .thenAnswer((_) async => const Right('not valid json {{{'));

      final result = await dataSource.getTrending();

      expect(result, const Left(ServerFailure.notAvailable));
      verify(mockLoggingService.error(any, error: anyNamed('error'), stackTrace: anyNamed('stackTrace'))).called(1);
    });
  });
}
