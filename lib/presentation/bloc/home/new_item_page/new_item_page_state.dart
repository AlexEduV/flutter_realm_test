import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';

part 'new_item_page_state.freezed.dart';

@freezed
abstract class NewItemPageState with _$NewItemPageState {
  const factory NewItemPageState({
    FieldParamsModel? manufacturerFieldParams,
    FieldParamsModel? modelFieldParams,
    FieldParamsModel? yearFieldParams,
    FieldParamsModel? colorFieldParams,
    String? manufacturerErrorText,
    String? modelErrorText,
    String? yearErrorText,
    String? colorErrorText,
    @Default(AppConstants.itemSetupTabType) int currentPageIndex,
  }) = _NewItemPageState;
}
