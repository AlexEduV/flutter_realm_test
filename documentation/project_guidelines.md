# Project Guidelines

This document consolidates best‑practice guidelines for developing, testing, and maintaining the **Flutter Realm Test** project. It complements the `README.md` and `CONTRIBUTING.md` files.

---

## 1. Project Structure
- **Clean Architecture** layout under `lib/`:
  - `common/` – shared enums, extensions, constants.
  - `data/` – data sources, DTOs, models, repository implementations.
  - `domain/` – entities, use‑cases, repository abstractions.
  - `presentation/` – UI layer (cubit/bloc, pages, widgets).
  - `utils/` – helpers (router, localisation, JSON utilities).
- Keep folder and file naming consistent (snake_case for files, PascalCase for classes).

---

## 2. Coding Standards
- **Dart style** – run `flutter format .` before committing.
- **Null‑safety** – avoid nullable types unless required.
- **DartDoc** – document all public APIs (classes, enums, methods) using Flutter’s documentation style.
- **Linting** – adhere to rules in `analysis_options.yaml`; do not disable lint rules without a strong justification.
- Prefer **explicit types** over `var` when the type is not obvious.

---

## 3. Testing Policy
- Write **unit tests** for business logic and **widget tests** for UI components.
- Place tests in `test/` mirroring the `lib/` structure.
- Aim for **≥ 80 % coverage** on new code.
- Run tests locally with `flutter test` before pushing.
- Use **Mockito** for mocking dependencies and `bloc_test` for cubit/bloc verification.

---

## 4. Version Control & Branching
- **Feature branches**: `feature/<short‑description>`.
- **Bug‑fix branches**: `bugfix/<short‑description>`.
- Follow **Conventional Commits** for commit messages:
  ```text
  type(scope?): subject
  
  body (optional)
  
  footer (e.g., "Closes #123")
  ```
  - `type` = `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
- Keep Pull Requests focused on a single logical change.

---

## 5. Continuous Integration
- GitHub Actions automatically run on every PR:
  - `flutter format --set-exit-if-changed .`
  - `flutter analyze`
  - `flutter test`
- All checks must pass before merging.

---

## 6. Documentation Updates
- Update the **README** when adding new features or changing the overall project scope.
- Keep this `project_guidelines.md` up‑to‑date as the project evolves.
- Add or modify documentation for any new architecture decisions, third‑party services, or tooling.

---

## 7. Permissions & Platform Concerns
- The app uses location services; request permissions via the `permission_handler` package.
- Ensure proper handling of platform‑specific permissions in both Android (`AndroidManifest.xml`) and iOS (`Info.plist`).
- Follow privacy best practices: explain why permissions are needed and provide fallback UI when denied.

---

## 8. License & Attribution
- The project is licensed under the MIT License – see the `LICENSE` file.
- When adding third‑party assets (icons, images, fonts), include proper attribution in the `README.md` and ensure the asset’s license permits usage.

---

## 10. Common Issues
# when writing tests for Shared Preferences, the error might popup: `MissingPluginException(No implementation found for method getAll on channel plugins.flutter.io/shared_preferences)`
# it just requires setting up mock data:
# `SharedPreferences.setMockInitialValues({}); // Mock empty storage`

---

*Happy coding!*