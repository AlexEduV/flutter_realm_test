# Flutter Realm Test

[![Flutter](https://img.shields.io/badge/Flutter-3.41-blue.svg)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Build Status](https://img.shields.io/github/actions/workflow/status/AlexEduV/flutter_realm_test/flutter.yml?branch=main)](https://github.com/AlexEduV/flutter_realm_test/actions)

A clean‑architecture Flutter sample app that showcases **RealmDB**, **GoRouter**, **Cubit**, **Mockito**, and **RxDart**. The app simulates an auto‑e‑commerce platform inspired by Auto.Ria.

## Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Running Tests](#running-tests)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

## Features
- **State management** with Cubit + comprehensive unit tests
- **Navigation** using GoRouter (deep‑link ready)
- **Local persistence** with RealmDB
- **Mocking & testing** via Mockito
- **Reactive streams** with RxDart
- Clean Architecture separation (data, domain, presentation)

## Architecture
```
lib/
├─ common/
│   ├─ enums/
│   ├─ extensions/
│   └─ constants/
├─ data/
│   ├─ data_sources/
│   ├─ dtos/
│   ├─ models/
│   └─ repositories/
├─ di/                # get_it service locator
├─ domain/
│   ├─ data_sources/
│   ├─ entities/
│   ├─ models/
│   ├─ repositories/
│   └─ usecases/
├─ presentation/
│   ├─ bloc/
│   └─ pages/
├─ utils/
│   ├─ router.dart
│   ├─ json_util.dart
│   ├─ l10n.dart
│   └─ localisation_util.dart
└─ main.dart
```

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/AlexEduV/flutter_realm_test.git
   cd flutter_realm_test
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Prerequisites
- Flutter SDK >= 3.41
- Xcode / Android Studio for device emulation
- RealmDB native libraries (handled by `flutter pub get`)

## Running Tests
```bash
# Unit & Cubit tests
flutter test

# Integration tests (if any)
flutter drive --target=test_driver/app.dart
```

## Roadmap
- Deeplink support with custom GoRouter routes
- Widget & golden tests (Alchemist / Storybook)
- Multi‑language localisation
- Flavors for QA & Production
- Firebase authentication integration
- Accessibility improvements
- Map integration (MapBox) with location permissions

## Contributing
Contributions are welcome! Please open an issue or submit a pull request. Follow the [contribution guidelines](CONTRIBUTING.md) (if present).

## License
This project is provided for educational purposes. See the `LICENSE` file for details. For commercial use, contact the author.

---

*Built with ❤️ by Alex*
