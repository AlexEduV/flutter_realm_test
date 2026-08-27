import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/share_params_model.dart';
import 'package:test_flutter_project/domain/repositories/share_repository.dart';
import 'package:test_flutter_project/presentation/features/share/share_cubit.dart';
import 'package:test_flutter_project/presentation/features/share/share_state.dart';

import '../../features/share/share_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ShareRepository>()])
void main() {
  group('ShareCubit', () {
    late MockShareRepository mockShareRepository;
    late ShareCubit shareCubit;

    setUp(() {
      mockShareRepository = MockShareRepository();
      shareCubit = ShareCubit(mockShareRepository);
    });

    test('should call ShareRepository with correct params', () async {
      // Arrange
      final params = ShareParamsModel(title: 'Simple title', text: 'Check this out!');
      when(mockShareRepository.share(params)).thenAnswer((_) async {});

      // Act
      await shareCubit.share(params);

      // Assert
      verify(mockShareRepository.share(params)).called(1);
      verifyNoMoreInteractions(mockShareRepository);
    });

    test('initial state is ShareState()', () {
      expect(shareCubit.state, const ShareState());
    });
  });
}
