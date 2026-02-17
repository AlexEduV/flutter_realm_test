class OwnerModel {
  final String id;
  final String name;
  final List<String> linkedItemIds;

  OwnerModel({required this.id, required this.name, required this.linkedItemIds});

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'] as String,
      name: json['full_name'] as String,
      linkedItemIds: json['linked_ids'] as List<String>,
    );
  }
}
