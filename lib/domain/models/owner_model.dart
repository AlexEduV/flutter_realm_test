class OwnerModel {
  final String id;
  final String name;
  final List<String> linkedItemIds;
  final String? imageSrc;

  OwnerModel({required this.id, required this.name, required this.linkedItemIds, this.imageSrc});

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'] as String,
      name: json['full_name'] as String,
      linkedItemIds: List<String>.from(json['linked_ids'] as List),
      imageSrc: json['image_src'] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          imageSrc == other.imageSrc &&
          _listEquals(linkedItemIds, other.linkedItemIds);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ imageSrc.hashCode ^ _listHash(linkedItemIds);

  static bool _listEquals(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static int _listHash(List list) {
    return list.fold(0, (prev, element) => prev ^ element.hashCode);
  }
}
