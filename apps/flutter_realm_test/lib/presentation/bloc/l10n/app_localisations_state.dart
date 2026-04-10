class AppLocalisationsState {
  final Map<String, String> localisations;

  const AppLocalisationsState({required this.localisations});

  String get(String key) => localisations[key] ?? '';
}
