# Integration Tests

## Running

```bash
# Requires a connected device or running simulator
make run-integration-tests
```

Integration tests are excluded from the regular suite and coverage runs via `--exclude-tags integration`.

## Key things to know before touching this suite

**`pumpAndSettle` is unreliable here.** Realm's `.watch()` streams keep the frame loop perpetually active, so `pumpAndSettle` never truly settles. Use `pump(Duration(...))` after any action that triggers a network call or navigation. `pumpAndSettle` is only safe for pure UI transitions with no active streams.

**App startup needs a fixed delay.** `app.main()` followed by `pumpAndSettle()` is not reliable — Realm initialisation and native splash removal are async. Use `pump(const Duration(seconds: 3))` after `app.main()` instead.

**Login is not the initial screen.** The app always opens on the explore page. The login form appears inside the account tab when the user is unauthenticated. Navigate there first before interacting with the login form.

**`AnimatedOpacity(opacity: 0)` hides widgets from the semantics tree.** `find.bySemanticsLabel` will not find widgets hidden this way unless `alwaysIncludeSemantics: true` is set on the `AnimatedOpacity`.

**Test isolation requires resetting both `SharedPreferences` and `serviceLocator`.** `app.main()` re-registers all GetIt dependencies on each run, so without `serviceLocator.reset()` in `setUp`, the second test will throw on duplicate registrations.

## Structure

Tests follow the **Page Object Model**: each screen has a dedicated class owning its finders and interactions. Test bodies only contain setup, POM calls, and assertions.
