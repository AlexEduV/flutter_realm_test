import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/share_params_model.dart';
import 'package:test_flutter_project/domain/repositories/share_repository.dart';
import 'package:test_flutter_project/domain/usecases/share/share_use_case.dart';

import 'share_use_case_test.mocks.dart';

@GenerateMocks([ShareRepository])
void main() {
  late MockShareRepository mockRepository;
  late ShareUseCase useCase;

  setUp(() {
    mockRepository = MockShareRepository();
    useCase = ShareUseCase(mockRepository);
  });

  test('should call share on repository with correct ShareParamsModel', () async {
    final params = ShareParamsModel(title: 'Test', text: 'Test Content');
    when(mockRepository.share(params)).thenAnswer((_) async {});

    await useCase.call(params);

    verify(mockRepository.share(params)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
