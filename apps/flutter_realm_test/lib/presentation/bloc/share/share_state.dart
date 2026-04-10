import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_state.freezed.dart';

@freezed
abstract class ShareState with _$ShareState {
  const factory ShareState({@Default(false) bool isLoading, String? error}) = _ShareState;
}
