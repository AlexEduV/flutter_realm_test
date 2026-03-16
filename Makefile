get:
	flutter pub get

clean:
	flutter clean

clean-get:
	$(MAKE) clean
	$(MAKE) get


# File Generation
clean-build:
	dart run build_runner clean
	$(MAKE) build-verbose-delete-conflicting-outputs

build-verbose-delete-conflicting-outputs:
	dart run build_runner build -v --delete-conflicting-outputs


# Tests
show-coverage:
	PATH=$$PATH:$$HOME/.pub-cache/bin \
	very_good test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

run-all-tests:
	flutter test


# Native Splash Commands
generate-native-splash:
	dart run flutter_native_splash:create

delete-native-splash:
	dart run flutter_native_splash:remove