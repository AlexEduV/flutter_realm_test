import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/url_launch_repository_impl.dart';
import 'package:test_flutter_project/domain/services/external_link_service.dart';

import 'url_launch_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ExternalLinkService>()])
void main() {
  late MockExternalLinkService mockLocalDataSource;
  late UrlLaunchRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockExternalLinkService();
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
