import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';

import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_dimensions.dart';
import '../../../../../common/constants/app_semantics_labels.dart';
import '../../../../../common/constants/app_text_styles.dart';
import '../../../../../l10n/l10n_keys.dart';
import '../../../../../utils/dialog_helper.dart';
import '../../../../bloc/messages/messages_page_cubit.dart';
import '../../../../bloc/messages/messages_page_state.dart';
import '../../../../widgets/app_semantics.dart';

class ChatInputTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function()? onMessageSent;
  final Function(BuildContext context, MessagesPageState state)? sendMessage;
  final GlobalKey<AnimatedListState> listKey;

  const ChatInputTextField({
    required this.focusNode,
    required this.textEditingController,
    required this.listKey,
    super.key,
    this.onMessageSent,
    this.sendMessage,
  });

  @override
  State<ChatInputTextField> createState() => _ChatInputTextFieldState();
}

class _ChatInputTextFieldState extends State<ChatInputTextField> {
  double textFieldScale = 1.0;
  final textFieldBorderRadius = BorderRadius.circular(AppDimensions.normalM);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesPageCubit, MessagesPageState>(
      builder: (context, state) {
        return AnimatedScale(
          scale: textFieldScale,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: TextFormField(
            onTap: onTextFieldTap,
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.all(AppDimensions.minorM),
                child: AppSemantics(
                  button: true,
                  label: AppSemanticsLabels.chatInputBarGifButton,
                  child: IconButton(
                    onLongPress: () {
                      //this blocks refocus on field when long pressing the button
                    },
                    icon: const Icon(Icons.gif, size: AppDimensions.bottomMessageBarIconSize),
                    onPressed: () async {
                      await DialogHelper.showGifsPickerModalBottomSheet(context, widget.listKey);
                      if (!context.mounted) return;

                      final result = context.read<MessagesPageCubit>().state.selectedGif;
                      if (result != null) {
                        widget.onMessageSent?.call();
                      }
                    },
                  ),
                ),
              ),
              hintStyle: AppTextStyles.zonaPro16.copyWith(color: AppColors.hintColor),
              hintText: context.tr(L10nKeys.messageBarHint),
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppDimensions.normalM,
                horizontal: AppDimensions.normalS,
              ),
              border: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: const BorderSide(color: AppColors.accentColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: const BorderSide(
                  color: AppColors.accentColor,
                  width: AppDimensions.minorXS,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              errorBorder: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            style: AppTextStyles.zonaPro16,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (newValue) => context.read<MessagesPageCubit>().updateMessageText(newValue),
            onFieldSubmitted: (value) {
              if (value.isEmpty) return;

              widget.sendMessage?.call(context, state);
            },
          ),
        );
      },
    );
  }

  Future<void> onTextFieldTap() async {
    setState(() => textFieldScale = 1.2);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => textFieldScale = 1.0);
  }
}
