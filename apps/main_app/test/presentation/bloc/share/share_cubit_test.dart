import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/models/share_params_model.dart';
import 'package:test_futter_project/domain/usecases/share/share_use_case.dart';
import 'package:test_futter_project/presentation/bloc/share/share_cubit.dart';
import 'package:test_futter_project/presentation/bloc/share/share_state.dart';

import 'share_cubit_test.mocks.dart';

@GenerateMocks([ShareUseCase])
void main() {
  group('ShareCubit', () {
    late MockShareUseCase mockShareUseCase;
    late ShareCubit shareCubit;

    setUp(() {
      mockShareUseCase = MockShareUseCase();
      shareCubit = ShareCubit(mockShareUseCase);
    });

    test('should call ShareUseCase with correct params', () async {
      // Arrange
      final params = ShareParamsModel(title: 'Simple title', text: 'Check this out!');
      when(mockShareUseCase.call(params)).thenAnswer((_) async {});

      // Act
      await shareCubit.share(params);

      // Assert
      verify(mockShareUseCase.call(params)).called(1);
      verifyNoMoreInteractions(mockShareUseCase);
    });

    test('initial state is ShareState()', () {
      expect(shareCubit.state, const ShareState());
    });
  });
}
