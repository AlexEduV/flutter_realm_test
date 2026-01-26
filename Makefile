clean-build:
	dart run build_runner clean
	dart run build_runner build -v --delete-conflicting-outputs
