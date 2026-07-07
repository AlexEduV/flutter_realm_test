class AppLocalisationsState {
  const AppLocalisationsState({required this.localisations});

  final Map<String, String> localisations;

  String get(String key) => localisations[key] ?? '';
}
