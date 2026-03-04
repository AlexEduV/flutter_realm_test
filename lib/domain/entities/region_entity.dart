class RegionEntity {
  final String locale;
  final String countryName;

  const RegionEntity({required this.locale, required this.countryName});

  static RegionEntity fromJson(Map<String, dynamic> json) {
    return RegionEntity(locale: json['code'] as String, countryName: json['fullName'] as String);
  }
}
