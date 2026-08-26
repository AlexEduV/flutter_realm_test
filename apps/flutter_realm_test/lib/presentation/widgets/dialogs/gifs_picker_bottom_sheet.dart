import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/domain/entities/gif_entity.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';
import 'package:test_flutter_project/presentation/widgets/network_error_widget.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../common/enums/message_status.dart';
import '../../../domain/models/message_model.dart';
import '../../features/inbox/inbox_page_cubit.dart';
import '../../features/inbox/inbox_page_identifiers.dart';
import '../../features/messages/messages_page_cubit.dart';
import '../../features/messages/messages_page_identifiers.dart';
import '../../features/messages/messages_page_state.dart';
import '../../features/user/user_data_cubit.dart';

class GifsPickerBottomSheet extends StatefulWidget {
  const GifsPickerBottomSheet({super.key});

  @override
  State<GifsPickerBottomSheet> createState() => _GifsPickerBottomSheetState();
}

class _GifsPickerBottomSheetState extends State<GifsPickerBottomSheet> {
  double _textFieldScale = 1.0;
  final _textController = TextEditingController();

  @override
  void initState() {
    context.read<MessagesPageCubit>().updateGifsSearch('');
    context.read<MessagesPageCubit>().updateSelectedGif(null);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textFieldBorderRadius = BorderRadius.circular(AppDimensions.normalL);

    return BlocBuilder<MessagesPageCubit, MessagesPageState>(
      builder: (context, state) {
        final isQueryEmpty = state.latestQuery.isEmpty;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.normalS).copyWith(bottom: 0.0),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: _textFieldScale,
                curve: Curves.easeInOut,
                child: TextFormField(
                  onTap: onTextFieldTap,
                  controller: _textController,
                  onChanged: (newValue) =>
                      context.read<MessagesPageCubit>().updateGifsSearch(newValue),
                  decoration: InputDecoration(
                    hintText: context.tr(InboxPageLocaleKeys.gifsTextFieldHint),
                    fillColor: AppColors.white,
                    filled: true,
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
                    hintStyle: AppTextStyles.zonaPro16.copyWith(color: AppColors.hintColor),
                  ),
                  style: AppTextStyles.zonaPro16,
                ),
              ),
            ),

            if (state.networkError == null)
              Expanded(
                child: Column(
                  children: [
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
                                      text: context.tr(
                                        InboxPageLocaleKeys.gifsResultsTrendingLabel,
                                      ),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )
                                  else ...[
                                    TextSpan(
                                      text: context.tr(InboxPageLocaleKeys.gifsResultsQueryLabel),
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
                        itemCount: state.gifsInSearch.length,
                        itemBuilder: (context, index) {
                          final gif = state.gifsInSearch[index];

                          return AppSemantics(
                            label: '${MessagesPageIds.gifListItem} ${gif.title}',
                            button: true,
                            child: Padding(
                              padding: const EdgeInsets.all(AppDimensions.minorXS),
                              child: InkWell(
                                onTap: () => onGifItemTap(gif),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: gif.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              const Expanded(child: NetworkErrorWidget()),
          ],
        );
      },
    );
  }

  Future<void> onTextFieldTap() async {
    setState(() => _textFieldScale = 1.2);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => _textFieldScale = 1.0);
  }

  Future<void> onGifItemTap(GifEntity gif) async {
    final payload = gif.toPayload();

    final userId = context.read<UserDataCubit>().state.user.userId;

    final conversationId = context.read<MessagesPageCubit>().state.currentConversationId;
    await context.read<InboxPageCubit>().sendMessage(
      conversationId,
      MessageModel(senderId: userId, messageStatus: MessageStatus.sent, payload: payload),
    );

    if (!mounted) return;
    context.read<MessagesPageCubit>().updateSelectedGif(payload);

    if (context.canPop()) {
      context.pop();
    }
  }
}
