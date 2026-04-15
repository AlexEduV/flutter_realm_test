import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/repositories/url_launch_repository.dart';
import 'package:test_flutter_project/domain/usecases/url/open_url_link_use_case.dart';

import 'open_url_link_use_case_test.mocks.dart';

@GenerateMocks([UrlLaunchRepository])
void main() {
  late MockUrlLaunchRepository mockRepository;
  late OpenUrlLinkUseCase useCase;

  setUp(() {
    mockRepository = MockUrlLaunchRepository();
    useCase = OpenUrlLinkUseCase(mockRepository);
  });

  test('should call openUrl on repository with correct link', () async {
    final link = 'https://example.com';
    when(mockRepository.openUrl(link)).thenAnswer((_) async {});

    await useCase.call(link);

    verify(mockRepository.openUrl(link)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
