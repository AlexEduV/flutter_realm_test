# Contributing Guidelines

Thank you for considering contributing to **Flutter Realm Test**! This document outlines the best practices and processes we follow to keep the project healthy, maintainable, and welcoming.

---

## Table of Contents
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Code Style & Formatting](#code-style--formatting)
- [Testing](#testing)
- [Commit Messages & Pull Requests](#commit-messages--pull-requests)
- [Issue Reporting](#issue-reporting)
- [Continuous Integration](#continuous-integration)
- [License & Attribution](#license--attribution)
- [Code of Conduct](#code-of-conduct)

---

## Getting Started
1. **Fork the repository** and clone your fork:
   ```bash
   git clone https://github.com/<your‑username>/flutter_realm_test.git
   cd flutter_realm_test
   ```
2. **Install the Flutter SDK** (>= 3.19) and ensure `flutter doctor` reports no issues.
3. **Install project dependencies**:
   ```bash
   flutter pub get
   ```
4. (Optional) Install the recommended IDE extensions for Dart/Flutter linting and formatting.

---

## Development Workflow
| Step | Description |
|------|-------------|
| **Create a branch** | `git checkout -b <type>/<short‑description>` (e.g., `feature/add-login`, `bugfix/fix‑crash`). |
| **Make changes** | Keep changes focused on a single concern. |
| **Run tests & lint** | `flutter test` and `flutter format .` (or `dart format .`). |
| **Commit** | Write a clear, conventional commit message (see below). |
| **Push & PR** | Push to your fork and open a Pull Request against `main`. |

---

## Code Style & Formatting
- Use the **Dart style guide** (see https://dart.dev/guides/language/effective-dart).
- Run `flutter format .` before committing.
- Prefer **null‑safety** and avoid `dynamic` where a concrete type is known.
- Add **DartDoc** comments for public APIs (enums, classes, methods) following the Flutter documentation style.
- Lint rules are defined in `analysis_options.yaml`; do not disable them without a strong reason.

---

## Testing
- Write **unit tests** for business logic and **widget tests** for UI components.
- Place tests in the `test/` directory mirroring the `lib/` structure.
- Run all tests with:
  ```bash
  flutter test
  ```
- Aim for **>80 % coverage** on new code.

---

## Commit Messages & Pull Requests
- Follow the **Conventional Commits** format:
  ```text
  type(scope?): subject
  
  body (optional)
  
  footer (optional, e.g., "Closes #123")
  ```
  - `type` can be `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
  - Keep the subject line ≤ 72 characters.
- In the PR description, include:
  - A short summary of the change.
  - Related issue numbers.
  - Screenshots or logs if applicable.
  - Any migration steps required.
- Ensure the CI pipeline passes before requesting review.

---

## Issue Reporting
- Search existing issues before opening a new one.
- Use the provided issue templates (Bug Report, Feature Request).
- Include:
  - Flutter version (`flutter --version`).
  - Device/emulator details.
  - Steps to reproduce.
  - Expected vs. actual behavior.

---

## Continuous Integration
- GitHub Actions run on every PR:
  - `flutter format --set-exit-if-changed .`
  - `flutter analyze`
  - `flutter test`
- Do not merge until the workflow shows **green**.

---

## License & Attribution
- This project is licensed under the MIT License – see the `LICENSE` file.
- When adding third‑party assets (icons, images), ensure they are appropriately licensed and credit the source in `README.md`.

---

## Code of Conduct
We adopt the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to abide by its terms.

---

Thank you for helping make **Flutter Realm Test** better! 🎉
