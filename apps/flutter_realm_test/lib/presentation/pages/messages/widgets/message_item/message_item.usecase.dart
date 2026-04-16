import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_flutter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/message_item/message_item.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_dimensions.dart';
import '../../../../../l10n/l10n_keys.dart';
import '../../../../bloc/l10n/app_localisations_cubit.dart';

Widget buildMessageItemUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()
    ..load({L10nKeys.gifMessagePlaceholder: 'Gif'});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.minorL),
        child: Column(
          spacing: AppDimensions.normalL,
          children: [
            MessageItem(
              senderName: context.knobs.string(label: 'Sender', initialValue: 'Some sender'),
              imageSrc: null,
              message: context.knobs.string(label: 'Message', initialValue: 'Some message'),
              messageStatus: MessageStatus.read,
              time: context.knobs.string(label: 'Time', initialValue: '17:00'),
              messageIndex: 1,
              conversationId: '1',
              isMyMessage: context.knobs.boolean(label: 'Is my message', initialValue: true),
              withExtendedData: context.knobs.boolean(
                label: 'Is first in chain',
                initialValue: true,
              ),
              imageMetaData: context.knobs.boolean(label: 'Is image', initialValue: false)
                  ? SentImageMetaDataModel(url: 'https://example.com/image', width: 50, height: 50)
                  : null,
              attachmentMetaData: context.knobs.boolean(label: 'Is Attachment', initialValue: false)
                  ? SentAttachmentMetaDataModel(
                      name: context.knobs.string(
                        label: 'Attachment file name',
                        initialValue: 'some_file.pdf',
                      ),
                      size: 68000,
                    )
                  : null,
            ),
          ],
        ),
      ),
    ),
  );
}
