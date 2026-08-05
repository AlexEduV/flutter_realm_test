# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a **Melos monorepo** managed via the root `pubspec.yaml` workspace config. It contains:
- `apps/flutter_realm_test/` — the main Flutter application (package name: `test_flutter_project`)
- `packages/core_ui/` — shared UI package

Most development happens inside `apps/flutter_realm_test/`.

## Commands

All commands below should be run from `apps/flutter_realm_test/` unless noted.

```bash
# Workspace bootstrap (from repo root)
melos bs

# Dependencies (from apps/flutter_realm_test/)
flutter pub get
make get              # same as above

# Run app (from apps/flutter_realm_test/)
flutter run

# Tests (from apps/flutter_realm_test/)
flutter test          # run all tests
flutter test test/path/to/foo_test.dart  # run a single test file
make run-all-tests    # run all tests with concurrency=4

# Code generation — must run from apps/flutter_realm_test/ (not repo root)
dart run build_runner build --delete-conflicting-outputs
# If outputs are stale/stuck, delete the generated file + cache then rebuild:
find . -path '*/.dart_tool/build' -type d -exec rm -rf {} + 2>/dev/null
dart run build_runner build --delete-conflicting-outputs

# Lint / format (from apps/flutter_realm_test/)
flutter analyze
flutter format .

# Coverage report (from apps/flutter_realm_test/, requires very_good_cli)
make show-coverage

# iOS pods (from repo root)
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

The root `pubspec.yaml` pins several packages for Realm compatibility. Do not remove these and do not duplicate them in sub-package `pubspec.yaml` files — with `resolution: workspace`, overrides must live only in the root:
```yaml
dependency_overrides:
  analyzer: 7.3.0
  test_api: 0.7.10
  test_core: 0.6.17
  dart_style: 2.3.7
  analyzer_plugin: 0.12.0
  build_runner: 2.4.9
  build_daemon: 4.0.1
```

## Pub Workspace

All packages declare `resolution: workspace` in their `pubspec.yaml`. This means:
- `pub get` / `flutter pub get` resolves dependencies at the workspace root, not per-package
- `dart run build_runner` must be run from the repo root (via `melos run build`), not from individual package directories — sub-packages lack their own `.dart_tool/package_config.json`
- `flutter test` still works from `apps/flutter_realm_test/` directly

## Testing

- Tests mirror `lib/` directory structure under `test/`
- Use **Mockito** for mocking interfaces; run `melos run build` from the repo root to regenerate mocks after interface changes
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
