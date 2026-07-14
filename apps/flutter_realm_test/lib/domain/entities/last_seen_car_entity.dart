import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_seen_car_entity.freezed.dart';

@freezed
abstract class LastSeenCarEntity with _$LastSeenCarEntity {
  const factory LastSeenCarEntity({
    required String carId,
    required DateTime seenAt,
  }) = _LastSeenCarEntity;
}
