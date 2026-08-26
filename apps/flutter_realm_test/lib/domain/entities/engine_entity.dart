import '../../common/enums/fuel_type.dart';

class EngineEntity {
  const EngineEntity({this.type, this.volume});

  factory EngineEntity.empty() {
    return EngineEntity(type: FuelType.gasoline.name);
  }

  final String? type;
  final String? volume;

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
