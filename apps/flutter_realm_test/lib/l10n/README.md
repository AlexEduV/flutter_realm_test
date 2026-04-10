# Localisations

This directory includes static keys for localisation. The actual structure comes from the
external data source, but for this project I use the mock data, which is then parsed and saved
to the local storage.

### Adding a localisation

To add localisation, add a new key the mock data for all languages in `assets/mocks/`.
Then use this key in the `l10n_keys.dart` to get a static const which can be used in the UI.

### Using localisations in the UI

Recently, I have added dynamic language change, which means, the localisation files are read during the
lifetime of the app multiple times. For most cases, use `context.tr` extension to watch localisation
changes in the text widgets. But it's not suited for the callbacks, like `onTap`, because they live
outside of the widget lifecycle, while the watcher forces the State.build on value change. So,
use `context.trRead` extension to only read the localisation.

```dart
//watcher function
@override
Widget build(BuildContext context) {
  return Text(context.tr('hello_world'));
}

//read-only function
@override
Widget build(BuildContext context) {
  return showDialog(title: context.trRead('hello_world'));
}
```
