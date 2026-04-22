import '../../common/enums/fuel_type.dart';

class EngineEntity {
  final String? type;
  final String? volume;

  const EngineEntity({this.type, this.volume});

  factory EngineEntity.empty() {
    return EngineEntity(type: FuelType.gasoline.name);
  }

  factory EngineEntity.fromJson(Map<String, dynamic> json) {
    return EngineEntity(type: json['type'] as String?, volume: json['volume'] as String?);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EngineEntity &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          volume == other.volume;

  @override
  int get hashCode => (type ?? '').hashCode ^ (volume ?? '').hashCode;
}
