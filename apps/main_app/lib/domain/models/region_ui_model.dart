class RegionUiModel {
  final String countryName;
  final String code;

  const RegionUiModel({required this.countryName, required this.code});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionUiModel &&
          runtimeType == other.runtimeType &&
          countryName == other.countryName &&
          code == other.code;

  @override
  int get hashCode => countryName.hashCode ^ code.hashCode;
}
