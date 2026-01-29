get:
	flutter pub get


clean-build:
	dart run build_runner clean
	dart run build_runner build -v --delete-conflicting-outputs


show-coverage:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html


run-all-tests:
	flutter test
