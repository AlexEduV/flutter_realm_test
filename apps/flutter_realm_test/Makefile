# MakeFile green play buttons are not working after updating to Android Studio 2026.1.1
# The commands work from Edit Configurations menu and the command line $ make, but the green
# play button cannot find a runner for Make. Will use make command until the problem can be resolved.
get:
	flutter pub get

clean:
	flutter clean

clean-get:
	$(MAKE) clean
	$(MAKE) get

format:
	find lib/ -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" ! -name "*.realm.dart" | xargs dart format


# File Generation - outdated, migrated to melos commands below.
#clean-build:
#	dart run build_runner clean
#	$(MAKE) build-verbose-delete-conflicting-outputs
#
#build-verbose-delete-conflicting-outputs:
#	dart run build_runner build -v --delete-conflicting-outputs


# Tests
#NOTE: very good cli produces flaky tests in CI-CD, regarding get it registration. It was one file after the
# other, so I migrated to flutter test.
show-coverage:
	PATH=$$PATH:$$HOME/.pub-cache/bin \
	flutter test --coverage --concurrency=4
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

run-all-tests:
	flutter test --concurrency=4


# Native Splash Commands
generate-native-splash:
	dart run flutter_native_splash:create

delete-native-splash:
	dart run flutter_native_splash:remove

# Melos
melos-init:
	melos bs

melos-clean:
	melos clean

melos-build:
	melos run build --scope=test_flutter_project

melos-build-clean:
	melos run build:clean --scope=test_flutter_project
