import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/share_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/share_local_data_source.dart';
import 'package:test_futter_project/domain/models/share_params_model.dart';

import 'share_repository_impl_test.mocks.dart';

@GenerateMocks([ShareLocalDataSource])
void main() {
  late MockShareLocalDataSource mockLocalDataSource;
  late ShareRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockShareLocalDataSource();
    repository = ShareRepositoryImpl(mockLocalDataSource);
  });

  // test('share calls local data source when not in progress', () async {
  //   final params = ShareParamsModel(text: 'https://example.com', title: 'Hello!');
  //   when(mockLocalDataSource.share(params)).thenAnswer((_) async {});
  //
  //   await repository.share(params);
  //
  //   verify(mockLocalDataSource.share(any)).called(1);
  //   // _isShareInProgress should be reset to false after completion
  //   await repository.share(params);
  //   verify(mockLocalDataSource.share(any)).called(2);
  // });

  test('share does not call local data source if already in progress', () async {
    final params = ShareParamsModel(text: 'https://example.com', title: 'Hello!');
    final completer = Completer<void>();
    when(mockLocalDataSource.share(params)).thenAnswer((_) => completer.future);

    // Start the first share, but don't await it yet
    final future1 = repository.share(params);

    // Immediately try to share again while the first is still in progress
    final future2 = repository.share(params);

    // Only the first call should be made
    verify(mockLocalDataSource.share(params)).called(1);

    // Complete the first share
    completer.complete();
    await future1;
    await future2; // This should return immediately

    // Still only one call should have been made
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
