import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/auth_error_code.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/usecases/authentication/delete_account_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/login_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/logout_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/register_use_case.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_state.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';

import '../../../utils/app_router_test.mocks.dart';
import 'authentication_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LogoutUseCase>(),
  MockSpec<LoginUseCase>(),
  MockSpec<RegisterUseCase>(),
  MockSpec<DeleteAccountUseCase>(),
])
void main() {
  late AuthenticationCubit cubit;
  late MockUserDataCubit mockUserDataCubit;

  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockDeleteAccountUseCase mockDeleteAccountUseCase;

  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    // Setup mock localisations
    final localisations = {
      'forms.fieldParams.email.label': 'Email',
      'forms.fieldParams.email.regexErrorMessage': 'Invalid email',
      'forms.fieldParams.validationMessage': 'Required',
      'forms.fieldParams.email.hintText': 'Enter email',
      'forms.fieldParams.password.label': 'Password',
      'forms.fieldParams.password.regexErrorMessage': 'Invalid password',
      'forms.fieldParams.password.hintText': 'Enter password',
      'forms.fieldParams.fullName.label': 'Full name',
      'forms.fieldParams.fullName.regexErrorMessage': 'Invalid name',
      'forms.fieldParams.fullName.hintText': 'Enter name',
      'forms.warnings.userNotFound': 'User not found',
      'forms.warnings.incorrectPassword': 'Incorrect password',
      'forms.warnings.userAlreadyExists': 'User already exists',
    };

    appLocalisationsCubit.load(localisations);

    provideDummy<AuthResult>(const AuthSuccess());

    mockUserDataCubit = MockUserDataCubit();
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockDeleteAccountUseCase = MockDeleteAccountUseCase();

    cubit = AuthenticationCubit(
      appLocalisationsCubit,
      mockUserDataCubit,
      mockLoginUseCase,
      mockLogoutUseCase,
      mockRegisterUseCase,
      mockDeleteAccountUseCase,
    );
    cubit.init();
  });

  group('AuthenticationCubit', () {
    test('initial state is correct', () {
      expect(cubit.state.isLoginMode, true);
      expect(cubit.state.emailFieldParams?.label, 'Email');
      expect(cubit.state.passwordFieldParams?.label, 'Password');
      expect(cubit.state.fullNameFieldParams?.label, 'Full name');
    });

    blocTest<AuthenticationCubit, AuthenticationState>(
      'updateEmail emits new state with updated email',
      build: () => cubit,
      act: (cubit) => cubit.updateEmail('test@mail.com'),
      expect: () => [cubit.state.copyWith(emailValue: 'test@mail.com')],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'setObscurePassword emits new state with updated obscure value',
      build: () => cubit,
      act: (cubit) => cubit.setObscurePassword(false),
      expect: () => [cubit.state.copyWith(isPasswordFieldObscure: false)],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'setNewFormModeToLogin resets form fields and errors',
      build: () => cubit,
      act: (cubit) => cubit.setNewFormModeToLogin(false),
      expect: () => [
        cubit.state.copyWith(
          isLoginMode: false,
          fullNameError: null,
          emailError: null,
          passwordError: null,
          passwordValue: '',
          fullNameValue: '',
          emailValue: '',
          authenticationErrorText: null,
        ),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'onLoginButtonPressed emits loading, calls repo, emits result and stops loading (success)',
      setUp: () {
        when(mockLoginUseCase.call(any)).thenAnswer((_) async => const AuthSuccess());
      },
      build: () {
        return cubit;
      },
      seed: () => cubit.state.copyWith(emailValue: 'a@mail.com', passwordValue: 'Password1!'),
      act: (cubit) => cubit.onLoginButtonPressed(),
      expect: () => [
        cubit.state.copyWith(authenticationErrorText: null, isLoading: true),
        // validation passes, so no error
        cubit.state.copyWith(isLoading: false),
      ],
      verify: (_) {
        verify(mockLoginUseCase.call(any)).called(1);
        verify(mockUserDataCubit.authUser('a@mail.com')).called(1);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'onLoginButtonPressed emits error if login fails',
      build: () {
        when(
          mockLoginUseCase.call(any),
        ).thenAnswer((_) async => AuthFailure(AuthErrorCode.userNotFound));
        return cubit;
      },
      seed: () => cubit.state.copyWith(emailValue: 'a@mail.com', passwordValue: 'Password1!'),
      act: (cubit) => cubit.onLoginButtonPressed(),
      expect: () => [
        cubit.state.copyWith(authenticationErrorText: null, isLoading: true),
        cubit.state.copyWith(authenticationErrorText: 'User not found', isLoading: true),
        cubit.state.copyWith(isLoading: false),
      ],
      verify: (_) {
        verify(mockLoginUseCase.call(any)).called(1);
        verifyNever(mockUserDataCubit.authUser('a@gmail.com'));
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'onRegisterButtonPressed emits loading, calls repo, emits result and stops loading (success)',
      build: () {
        when(mockRegisterUseCase.call(any)).thenAnswer((_) async => const AuthSuccess());
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        emailValue: 'a@mail.com',
        passwordValue: 'Password1!',
        fullNameValue: 'Test User',
      ),
      act: (cubit) => cubit.onRegisterButtonPressed(),
      expect: () => [
        cubit.state.copyWith(authenticationErrorText: null, isLoading: false),
        cubit.state.copyWith(isLoading: true),
        cubit.state.copyWith(isLoading: false),
      ],
      verify: (_) {
        verify(mockRegisterUseCase.call(any)).called(1);
        verify(mockUserDataCubit.authUser('a@mail.com')).called(1);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'onRegisterButtonPressed emits error if register fails',
      build: () {
        when(
          mockRegisterUseCase.call(any),
        ).thenAnswer((_) async => AuthFailure(AuthErrorCode.userAlreadyExists));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        emailValue: 'a@mail.com',
        passwordValue: 'Password1!',
        fullNameValue: 'Test User',
      ),
      act: (cubit) => cubit.onRegisterButtonPressed(),
      expect: () => [
        cubit.state.copyWith(authenticationErrorText: null, isLoading: false),
        cubit.state.copyWith(authenticationErrorText: null, isLoading: true),
        cubit.state.copyWith(authenticationErrorText: 'User already exists', isLoading: true),
        cubit.state.copyWith(isLoading: false),
      ],
      verify: (_) {
        verify(mockRegisterUseCase.call(any)).called(1);
        verifyNever(mockUserDataCubit.authUser('a@gmail.com'));
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'logOut calls repository and resets to login mode',
      build: () => cubit,
      act: (cubit) => cubit.logOut(),
      expect: () => [],
      verify: (_) {
        verify(mockLogoutUseCase.call()).called(1);
      },
    );
  });
}
