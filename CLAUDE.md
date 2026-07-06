# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a **Melos monorepo** managed via the root `pubspec.yaml` workspace config. It contains:
- `apps/flutter_realm_test/` — the main Flutter application (package name: `test_flutter_project`)
- `packages/realm_ui_core/` — shared UI package

Most development happens inside `apps/flutter_realm_test/`.

## Commands

All commands below should be run from `apps/flutter_realm_test/` unless noted.

```bash
# Dependencies
flutter pub get
make get              # same as above

# Run app
flutter run

# Tests
flutter test          # run all tests
flutter test test/path/to/foo_test.dart  # run a single test file

# Code generation (Freezed, Mockito, Realm)
make clean-build      # clean + regenerate all generated files

# Lint / format
flutter analyze
flutter format .

# Coverage report (requires very_good_cli)
make show-coverage

# Melos workspace bootstrap (from repo root)
melos bs

# iOS pods
melos pods:clean
```

CI runs `flutter format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` on every PR.

## Architecture

The app follows **Clean Architecture** with four layers:

```
presentation/  →  domain/  ←  data/
                  entities/
```

- **`common/`** — enums, extensions, constants
- **`data/`** — data sources (mostly mocked; only `GifsRemoteDataSource` hits real HTTP), DTOs, Realm models, repository implementations
- **`domain/`** — entities, use-case interfaces, repository abstractions
- **`presentation/`** — Cubits + pages/widgets
- **`utils/`** — `AppRouter` (GoRouter), localization, JSON helpers
- **`core/di/injection_container.dart`** — GetIt service locator (~90 registrations)

**State management**: `flutter_bloc` Cubits only (no BLoCs). Cubits call `.init()` on startup to trigger data fetching. Pages use `MultiBlocProvider`.

**Navigation**: GoRouter (`AppRouter` class). Routes are defined in `common/constants/app_routes.dart`. Uses `CupertinoPage` transitions by default with custom slide transitions for specific flows.

**Persistence**: RealmDB with 5 schema models (`Car`, `Person`, `User`, `LastSeenCar`, `Engine`). 29+ schema versions with migrations in `realm_configuration.dart`. Use `List<T>.from(realmList)` when mapping Realm lists to entities — direct assignment causes update exceptions.

**Reactive streams**: RxDart used alongside Realm's `.watch()` streams.

## Dependency Overrides

The root `pubspec.yaml` pins several packages for Realm compatibility:
```yaml
dependency_overrides:
  analyzer: 7.3.0
  test_api: 0.7.4
  dart_style: 2.3.7
  analyzer_plugin: 0.12.0
  build_runner: 2.4.9
  build_daemon: 4.0.1
```
Do not remove these — Realm's code generator requires them.

## Testing

- Tests mirror `lib/` directory structure under `test/`
- Use **Mockito** for mocking interfaces; run `make clean-build` to regenerate mocks after interface changes
- Use **bloc_test** for Cubit verification
- For tests using `SharedPreferences`, add `SharedPreferences.setMockInitialValues({})` in setUp
- `flutter pub get` runs automatically before every test run (Flutter 3.13+ behavior, cannot be disabled)

## Commit Convention

Follow Conventional Commits:
```
type(scope?): subject
```
Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Branch naming: `feature/<short-description>` or `bugfix/<short-description>`
