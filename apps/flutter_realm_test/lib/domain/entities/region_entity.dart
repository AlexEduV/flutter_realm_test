class RegionEntity {
  const RegionEntity({required this.locale});

  final String locale;

  static RegionEntity fromJson(Map<String, dynamic> json) {
    return RegionEntity(locale: json['code'] as String);
  }
}
