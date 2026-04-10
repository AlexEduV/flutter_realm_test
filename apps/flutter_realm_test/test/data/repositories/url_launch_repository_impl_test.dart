import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/url_launch_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/url_launch_local_data_source.dart';

import 'url_launch_repository_impl_test.mocks.dart';

@GenerateMocks([UrlLaunchLocalDataSource])
void main() {
  late MockUrlLaunchLocalDataSource mockLocalDataSource;
  late UrlLaunchRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockUrlLaunchLocalDataSource();
    repository = UrlLaunchRepositoryImpl(mockLocalDataSource);
  });

  test('openUrl calls local data source with correct link', () async {
    const link = 'https://example.com';
    when(mockLocalDataSource.openUrl(link)).thenAnswer((_) async {});

    await repository.openUrl(link);

    verify(mockLocalDataSource.openUrl(link)).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
