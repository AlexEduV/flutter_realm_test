import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

part 'user_data_state.freezed.dart';

@freezed
abstract class UserDataState with _$UserDataState {
  const UserDataState._();

  const factory UserDataState({
    required UserEntity user,
    @Default(false) bool isLoading,
    @Default(false) bool isUserAuthenticated,
  }) = _UserDataState;

  bool get isDataClear =>
      user.favoriteIds.isEmpty && user.viewedIds.isEmpty && user.createdIds.isEmpty;
}
