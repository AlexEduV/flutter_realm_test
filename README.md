# test_flutter_project

A Test Flutter Project utilizing RealmDB, GoRouter, and Mockito.

## Summary

This project is a mobile application that models an Auto E-commerce platform, inspired by apps like Auto.Ria.

Key technologies and practices used:
- **State Management:** Cubit, with comprehensive cubit tests.
- **Navigation:** GoRouter for robust and scalable routing.
- **Local Storage:** RealmDB for efficient offline data management.
- **Unit Testing:** Mockito for mocking and testing.
- **Reactive Programming:** RxDart and streams for simulating API calls.
- **Architecture:** Follows Clean Architecture and best practices for maintainability and scalability.

The primary goal of this project is to gain hands-on experience with these libraries and architectural patterns.

## Project Structure

```
lib/
├── common/
│   ├── enums/
│   ├── extensions/
│   └── constansts here...
├── data/
│   ├── data_sources/ - data sources and services implementations
│   ├── dtos/
│   ├── models/       - Models for data layer
│   └── repositories/ - Implementations of the repositories
├── di/               - getIt container
├── domain/
│   ├── data_sources/
│   ├── entities/
│   ├── models/       - models for presentation layer
│   ├── repositories/ - abstractions of repositories
│   └── usecases/
├── presentation/
│   ├── bloc/         - blocs and states per page
│   └── pages/        - pages and widgets
├── utils/
│   ├── router.dart
│   ├── json_util.dart          - json parser
│   ├── l10n.dart               - localisations strings
│   ├── localisation_util.dart  - localisation parser
└── main.dart

```

## Roadmap

- **Deeplink Support:** Implement custom routes and deeplinks in GoRouter.
- **Widget Testing:** Cover widgets with unit and golden tests (using Alchemist or Storybook for enhanced UI testing).
- **Localization:** Add mock localization API calls and localize the app for multiple languages.
- **Flavors:** Support for QA and Production environments using Flutter flavors.
- **Authentication:** Potential integration of Firebase authentication.
- **Accessibility:** Improve semantics and accessibility throughout the app.
- **Permissions & Maps:** Handle location permissions and possibly integrate MapBox for map features.

## Design

The base design is inspired by [this Dribbble shot](https://dribbble.com/shots/17097339-Vehicle-Retailer-App).  
The app uses the custom Zona Pro font for a unique and modern look.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AlexEduV/flutter__realm_test.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements, bug fixes, or new features.

## License

This project is for educational purposes and does not have a formal license.  
If you wish to use it commercially, please contact the author.