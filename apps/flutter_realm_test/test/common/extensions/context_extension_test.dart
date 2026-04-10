import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_state.dart';

import 'context_extension_test.mocks.dart';

@GenerateMocks([AppLocalisationsCubit, AppLocalisationsState])
void main() {
  late MockAppLocalisationsCubit mockCubit;
  late MockAppLocalisationsState mockState;

  setUp(() {
    mockCubit = MockAppLocalisationsCubit();
    mockState = MockAppLocalisationsState();
    when(mockCubit.state).thenReturn(mockState);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: BlocProvider<AppLocalisationsCubit>.value(value: mockCubit, child: child),
    );
  }

  testWidgets('tr returns localized string using watch', (tester) async {
    const testKey = 'test.key';
    const testValue = 'Test Value';

    when(mockState.get(testKey)).thenReturn(testValue);

    late String result;

    await tester.pumpWidget(
      buildTestWidget(
        child: Builder(
          builder: (context) {
            result = context.tr(testKey);
            return Container();
          },
        ),
      ),
    );

    expect(result, testValue);
    verify(mockCubit.state).called(1);
    verify(mockState.get(testKey)).called(1);
  });

  testWidgets('trRead returns localized string using read', (tester) async {
    const testKey = 'test.key';
    const testValue = 'Test Value';

    when(mockState.get(testKey)).thenReturn(testValue);

    late String result;

    await tester.pumpWidget(
      buildTestWidget(
        child: Builder(
          builder: (context) {
            result = context.trRead(testKey);
            return Container();
          },
        ),
      ),
    );

    expect(result, testValue);
    verify(mockCubit.state).called(1);
    verify(mockState.get(testKey)).called(1);
  });
}
