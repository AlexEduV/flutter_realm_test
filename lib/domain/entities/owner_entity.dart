import 'package:test_futter_project/domain/entities/user_entity.dart';

class OwnerEntity {
  final String id;
  final String firstName;
  final String lastName;
  final List<String> linkedItemIds;
  final String? imageSrc;

  OwnerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.linkedItemIds,
    this.imageSrc,
  });

  factory OwnerEntity.fromJson(Map<String, dynamic> json) {
    return OwnerEntity(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      linkedItemIds: List<String>.from(json['linked_ids'] as List),
      imageSrc: json['image_src'] as String?,
    );
  }

  factory OwnerEntity.empty() {
    return OwnerEntity(id: '', firstName: '', lastName: '', linkedItemIds: []);
  }

  factory OwnerEntity.fromUser(UserEntity user) {
    return OwnerEntity(
      id: user.userId,
      firstName: user.firstName,
      lastName: user.lastName,
      linkedItemIds: user.createdIds,
      imageSrc: user.avatarImageSrc,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          imageSrc == other.imageSrc &&
          _listEquals(linkedItemIds, other.linkedItemIds);

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      imageSrc.hashCode ^
      _listHash(linkedItemIds);

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
