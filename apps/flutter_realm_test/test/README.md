# Test Suite

Unit and Cubit tests for `test_flutter_project`. Tests mirror the `lib/` directory structure.

## Running Tests

```bash
# All tests
flutter test

# Single file
flutter test test/path/to/foo_test.dart

# All tests with concurrency
make run-all-tests

# By tag
flutter test --tags "streams"
```

## Test Tags

Tags let you run a subset of tests selectively. They are defined in `dart_test.yaml` (at the package root) and applied per test via the `tags` parameter.

### Defining tags

Register every tag in `dart_test.yaml` before using it — unregistered tags produce a warning and are silently ignored at runtime:

```yaml
# dart_test.yaml
tags:
  streams:
  slow:
```

### Applying tags to individual tests

```dart
test('description', () {
  // ...
}, tags: ['streams']);
```

### Why not on `group()`?

The underlying `test_api` package's `group()` does accept a `tags` parameter, but **`flutter_test` re-exports a trimmed wrapper** (`test_compat.dart`) that only exposes `skip` and `retry`. As a result, `tags` on `group()` is not available when importing `flutter_test`.

To tag an entire group, either repeat `tags` on each `test()` inside it, or use a file-level annotation (see below).

### File-level tags via `@Tags`

To tag every test in a file at once, use the `@Tags` annotation. It requires a `library;` directive so the annotation binds to the library declaration rather than to the first `import`:

```dart
@Tags(['streams'])
library;

import 'package:flutter_test/flutter_test.dart';
// ...
```

Without `library;`, the annotation silently attaches to the next statement and has no effect.

### Config file extension

The test runner recognises `dart_test.yaml` only — **not** `dart_test.yml`. A `.yml` file is silently ignored, tags appear unregistered, and `--tags` filtering produces no results.

## Mocking

Mocks are generated with Mockito. After changing an interface, regenerate from the repo root:

```bash
melos run build
```

For tests that use `SharedPreferences`, add this to `setUp`:

```dart
SharedPreferences.setMockInitialValues({});
```
