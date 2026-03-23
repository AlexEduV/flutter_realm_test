import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../common/app_colors.dart';
import '../../common/app_dimensions.dart';
import '../../common/app_text_styles.dart';
import '../../common/enums/message_status.dart';
import '../../domain/models/message_model.dart';
import '../../l10n/l10n_keys.dart';
import '../bloc/home/inbox_page/inbox_page_cubit.dart';
import '../bloc/messages/messages_page_cubit.dart';
import '../bloc/messages/messages_page_state.dart';
import '../bloc/user/user_data_cubit.dart';

class GifsPickerBottomSheet extends StatefulWidget {
  const GifsPickerBottomSheet({super.key});

  @override
  State<GifsPickerBottomSheet> createState() => _GifsPickerBottomSheetState();
}

class _GifsPickerBottomSheetState extends State<GifsPickerBottomSheet> {
  double textFieldScale = 1.0;
  final textController = TextEditingController();

  @override
  void initState() {
    context.read<MessagesPageCubit>().updateGifsSearch('');
    context.read<MessagesPageCubit>().updateSelectedGif(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesPageCubit, MessagesPageState>(
      builder: (context, state) {
        final isQueryEmpty = state.latestQuery.isEmpty;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.normalS).copyWith(bottom: 0.0),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: textFieldScale,
                curve: Curves.easeInOut,
                child: TextFormField(
                  onTap: onTextFieldTap,
                  controller: textController,
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
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.normalM),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: state.gifsInSearch.length,
                itemBuilder: (context, index) {
                  final gif = state.gifsInSearch[index];

                  return Padding(
                    padding: const EdgeInsets.all(AppDimensions.minorXS),
                    child: InkWell(
                      onTap: () => onGifItemTap(gif),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: gif.imageUrl,
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
  }

  Future<void> onTextFieldTap() async {
    setState(() => textFieldScale = 1.2);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => textFieldScale = 1.0);
  }

  void onGifItemTap(GifEntity gif) {
    final payload = gif.toPayload();

    final userId = context.read<UserDataCubit>().user.userId;

    final conversationId = context.read<MessagesPageCubit>().state.currentConversationId;
    context.read<InboxPageCubit>().sendMessage(
      conversationId,
      MessageModel(
        senderId: userId,
        messageStatus: MessageStatus.sent,
        payload: payload,
        date: DateTime.now(),
      ),
    );

    context.read<MessagesPageCubit>().updateSelectedGif(payload);
    context.pop();
  }
}
