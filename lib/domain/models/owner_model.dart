class OwnerModel {
  final String id;
  final String name;
  final List<String> linkedItemIds;

  OwnerModel({required this.id, required this.name, required this.linkedItemIds});

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(id: json['id'], name: json['full_name'], linkedItemIds: json['linked_ids']);
  }
}
