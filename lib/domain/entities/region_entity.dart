class RegionEntity {
  final String locale;

  const RegionEntity({required this.locale});

  static RegionEntity fromJson(Map<String, dynamic> json) {
    return RegionEntity(locale: json['code'] as String);
  }
}
