import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_state.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/widgets/edit_password_field_widget.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:transparent_image/transparent_image.dart';

import '../common/enums/message_status.dart';

class DialogHelper {
  static void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback? onConfirm,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    bool isDeletion = true,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700)),
          content: Text(description),
          backgroundColor: Colors.white,
          actions: [
            AppSemantics(
              label: AppSemanticsLabels.dialogCancelButton,
              button: true,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Text(cancelButtonTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            AppSemantics(
              label: AppSemanticsLabels.dialogConfirmButton,
              button: true,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
                style: isDeletion
                    ? const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red))
                    : null,
                child: Text(
                  confirmButtonTitle,
                  style: TextStyle(
                    color: isDeletion ? Colors.white : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showEditDialog(
    BuildContext context, {
    required String title,
    required String initialValue,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    required void Function(String)? onConfirm,
    VoidCallback? onCancel,
    bool Function(String)? validationCallback,
    TextInputType textInputType = TextInputType.text,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final textEditingController = TextEditingController();
        final focusNode = FocusNode();

        textEditingController.text = initialValue;
        _validateEditField(context, textEditingController.text, validationCallback);

        return BlocBuilder<EditDialogCubit, EditDialogState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                title,
                style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
              ),
              content: AppSemantics(
                textField: true,
                label: AppSemanticsLabels.dialogEditField,
                child: TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (newValue) =>
                      _validateEditField(context, newValue, validationCallback),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.normalS),
                      borderSide: const BorderSide(color: AppColors.accentColor),
                    ),
                  ),
                  keyboardType: textInputType,
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                AppSemantics(
                  label: AppSemanticsLabels.dialogCancelButton,
                  button: true,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    child: Text(
                      cancelButtonTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                AppSemantics(
                  label: AppSemanticsLabels.dialogConfirmButton,
                  button: true,
                  enabled: state.isConfirmButtonEnabled,
                  child: ElevatedButton(
                    onPressed: state.isConfirmButtonEnabled
                        ? () {
                            Navigator.of(context).pop();
                            onConfirm?.call(textEditingController.text);
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey;
                        }
                        return AppColors.headerColor;
                      }),
                      foregroundColor: const WidgetStatePropertyAll(Colors.white),
                    ),
                    child: Text(
                      confirmButtonTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void showEditPasswordDialog(
    BuildContext context, {
    required String title,
    required String initialValue,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    required void Function(String)? onConfirm,
    VoidCallback? onCancel,
    bool Function(String)? validationCallback,
    bool isPasswordField = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final textEditingController = TextEditingController();
        final confirmationTextEditingController = TextEditingController();
        final focusNode = FocusNode();
        final confirmationFocusNode = FocusNode();

        _validateEditField(context, textEditingController.text, validationCallback);
        _validateEditField(context, confirmationTextEditingController.text, validationCallback);

        return BlocBuilder<EditDialogCubit, EditDialogState>(
          builder: (context, state) {
            final isConfirmButtonEnabled =
                state.isConfirmButtonEnabled &&
                textEditingController.text == confirmationTextEditingController.text;

            return AlertDialog(
              title: Text(
                title,
                style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: AppDimensions.minorL,
                children: [
                  Text(context.tr(L10nKeys.personalDetailsItemPasswordDialogLabel)),

                  EditPasswordFieldWidget(
                    textEditingController: textEditingController,
                    focusNode: focusNode,
                    validateEditField: _validateEditField,
                    validationCallback: validationCallback,
                    isObscureText: state.isPasswordFieldObscure,
                    onSuffixIconTap: () => context
                        .read<EditDialogCubit>()
                        .setPasswordFieldObscurity(!state.isPasswordFieldObscure),
                  ),

                  const SizedBox(height: AppDimensions.minorS),

                  Text(context.tr(L10nKeys.personalDetailsItemPasswordDialogSecondLabel)),

                  EditPasswordFieldWidget(
                    textEditingController: confirmationTextEditingController,
                    focusNode: confirmationFocusNode,
                    validationCallback: validationCallback,
                    validateEditField: _validateEditField,
                    isObscureText: state.isConfirmationPasswordFieldObscure,
                    onSuffixIconTap: () =>
                        context.read<EditDialogCubit>().setPasswordConfirmationFieldObscurity(
                          !state.isConfirmationPasswordFieldObscure,
                        ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              actions: [
                AppSemantics(
                  label: AppSemanticsLabels.dialogCancelButton,
                  button: true,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    child: Text(
                      cancelButtonTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                AppSemantics(
                  label: AppSemanticsLabels.dialogConfirmButton,
                  button: true,
                  enabled: isConfirmButtonEnabled,
                  child: ElevatedButton(
                    onPressed: isConfirmButtonEnabled
                        ? () {
                            Navigator.of(context).pop();
                            onConfirm?.call(textEditingController.text);
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey;
                        }
                        return AppColors.headerColor;
                      }),
                      foregroundColor: const WidgetStatePropertyAll(Colors.white),
                    ),
                    child: Text(
                      confirmButtonTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<RegionUiModel?> showCountryPicker(
    BuildContext context,
    List<RegionUiModel> items,
    int currentIndex,
  ) async {
    return await showModalBottomSheet<RegionUiModel>(
      context: context,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.normalM),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsetsGeometry.symmetric(
                horizontal: AppDimensions.normalM,
                vertical: AppDimensions.minorS,
              ),
              leading: Container(
                height: AppDimensions.regionFlagIconSize,
                width: AppDimensions.regionFlagIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3.0, color: AppColors.accentColor),
                ),
                child: Image.asset(
                  '${AppAssetRoutes.flagRoute}${items[index].code}.png',
                  height: AppDimensions.regionFlagIconSize,
                  width: AppDimensions.regionFlagIconSize,
                ),
              ),
              title: Text(
                items[index].countryName,
                style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
              ),
              selected: index == currentIndex,
              selectedTileColor: AppColors.lightGrey,
              onTap: () => Navigator.pop(context, items[index]),
            );
          },
        );
      },
    );
  }

  static Future<void> showInboxItemModalBottomSheet(
    BuildContext context,
    String conversationId,
  ) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.scaffoldColor,
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                await context.read<InboxPageCubit>().deleteConversation(conversationId);

                if (!context.mounted) return;
                context.pop();
              },
              isDestructiveAction: true,
              child: Text(context.tr(L10nKeys.conversationDialogDeleteItemTitle)),
            ),
          ],
        );
      },
    );
  }

  static Future<String?> showGifsPickerModalBottomSheet(BuildContext context) async {
    String? result;

    await showModalBottomSheet<String?>(
      backgroundColor: AppColors.scaffoldColor,
      context: context,
      builder: (context) {
        context.read<MessagesPageCubit>().updateMessageText('');
        final initialText = '';

        final textEditingController = TextEditingController();
        textEditingController.text = initialText;
        context.read<MessagesPageCubit>().updateGifsSearch(initialText);

        return BlocBuilder<MessagesPageCubit, MessagesPageState>(
          builder: (context, state) {
            final isQueryEmpty = state.latestQuery.isEmpty;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.minorL),
                  child: TextFormField(
                    controller: textEditingController,
                    onChanged: (newValue) =>
                        context.read<MessagesPageCubit>().updateGifsSearch(newValue),
                    decoration: InputDecoration(
                      hintText: context.tr(L10nKeys.gifsTextFieldHint),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.normalL),
                        borderSide: const BorderSide(color: AppColors.accentColor),
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.normalS),
                        child: Text.rich(
                          TextSpan(
                            style: AppTextStyles.zonaPro18,
                            children: [
                              if (isQueryEmpty)
                                TextSpan(
                                  text: context.tr(L10nKeys.gifsResultsTrendingLabel),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              else ...[
                                TextSpan(
                                  text: context.tr(L10nKeys.gifsResultsQueryLabel),
                                  style: AppTextStyles.zonaPro18,
                                ),
                                TextSpan(
                                  text: '"${state.latestQuery}"',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.gifsUrls.length,
                    itemBuilder: (context, index) {
                      final gifUrl = state.gifsUrls[index];

                      return Padding(
                        padding: const EdgeInsets.all(AppDimensions.minorXS),
                        child: InkWell(
                          onTap: () {
                            final message = 'gifUrl: $gifUrl';
                            final userId = context.read<UserDataCubit>().user.userId;

                            final conversationId = context
                                .read<MessagesPageCubit>()
                                .state
                                .currentConversationId;
                            context.read<InboxPageCubit>().sendMessage(
                              conversationId,
                              MessageModel(userId, MessageStatus.sent, message, DateTime.now()),
                            );

                            result = message;
                            context.pop();
                          },
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: gifUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    return result;
  }

  static void _validateEditField(
    BuildContext context,
    String newValue,
    bool Function(String)? validationCallback,
  ) {
    final isValid = validationCallback?.call(newValue);
    context.read<EditDialogCubit>().setConfirmButtonEnabled(isValid ?? false);
  }
}
