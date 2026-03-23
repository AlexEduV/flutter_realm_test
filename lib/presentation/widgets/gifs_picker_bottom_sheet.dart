import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
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
  String? result;

  @override
  void initState() {
    context.read<MessagesPageCubit>().updateGifsSearch('');
    super.initState();
  }

  @override
  void dispose() {
    context.read<MessagesPageCubit>().updateSelectedGif(result);

    super.dispose();
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
                  onTap: () async {
                    setState(() => textFieldScale = 1.2);
                    await Future.delayed(const Duration(milliseconds: 100));
                    setState(() => textFieldScale = 1.0);
                  },
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
                      onTap: () {
                        //todo: not the best solution of storing the data
                        final message = jsonEncode({
                          'url': gif.imageUrl,
                          'width': gif.width.toString(),
                          'height': gif.height.toString(),
                        });

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
}
