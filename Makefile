get:
	flutter pub get

clean:
	flutter clean


clean-build:
	dart run build_runner clean
	dart run build_runner build -v --delete-conflicting-outputs


build-verbose-delete-conflicting-outputs:
	dart run build_runner build -v --delete-conflicting-outputs

show-coverage:
	PATH=$$PATH:$$HOME/.pub-cache/bin \
	very_good test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html


run-all-tests:
	flutter test

generate-native-splash:
	dart run flutter_native_splash:create